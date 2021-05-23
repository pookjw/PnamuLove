#import "LogParser.h"
#import "HSCardFactory.h"

@interface LogParser ()
@property LogReader *logReader;
@end

@implementation LogParser

+ (LogParser *)sharedInstance {
    static LogParser *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [LogParser new];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        self.logReader = LogReader.sharedInstance; 
    }

    return self;
}

- (instancetype)initWithLogReader:(LogReader *)logReader {
    self = [self init];

    if (self) {
        self.logReader = logReader; 
    }

    return self;
}

- (void)startObserving {
    [self.logReader startObserving];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleNewLogEvent:)
                                               name:kLogReaderNewLogNotificationName
                                             object:self.logReader];
}

- (void)stopObserving {
    [self.logReader stopObserving];
    [NSNotificationCenter.defaultCenter removeObserver:self
                                                  name:kLogReaderNewLogNotificationName
                                                object:self.logReader];
}

- (void)handleNewLogEvent:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *log = userInfo[@"log"];

    if (log) {
        [self postDidStartTheGameNotificationIfNeeded:log];
        [self postDidEndTheGameNotificationIfNeeded:log];
        [self postDidRemoveCardFromDeckNotificationIfNeeded:log];
        [self postDidAddCardToDeckNotificationIfNeeded:log];
    }
}

- (void)postDidStartTheGameNotificationIfNeeded:(NSString *)log {
    if ([log containsString:@"Gameplay.Start()"]) {
        [NSNotificationCenter.defaultCenter postNotificationName:kLogParserDidStartTheGameNotificationName
                                                   object:self
                                                 userInfo:nil];
    }
}

- (void)postDidEndTheGameNotificationIfNeeded:(NSString *)log {
    if ([log containsString:@"Gameplay.Unload()"]) {
        [NSNotificationCenter.defaultCenter postNotificationName:kLogParserDidEndTheGameNotificationName
                                                   object:self
                                                 userInfo:nil];
    }
}

- (void)postDidRemoveCardFromDeckNotificationIfNeeded:(NSString *)log {
    if ([log containsString:@"FRIENDLY DECK ->"]) {
        HSCard *card = [self hsCardFromCardLog:log];
        if (card) {
            [NSNotificationCenter.defaultCenter postNotificationName:kLogParserDidRemoveCardFromDeckNotificationName
                                                   object:self
                                                 userInfo:@{@"card": card}];
        }
    }
}

- (void)postDidAddCardToDeckNotificationIfNeeded:(NSString *)log {
    if ([log containsString:@"-> FRIENDLY DECK"]) {
        HSCard *card = [self hsCardFromCardLog:log];
        if (card) {
            [NSNotificationCenter.defaultCenter postNotificationName:kLogParserDidAddCardToDeckNotificationName
                                                   object:self
                                                 userInfo:@{@"card": card}];
        }
    }
}

- (HSCard * _Nullable)hsCardFromCardLog:(NSString *)log {
    NSString * __block _Nullable cardId = nil;
    NSArray<NSString *> *logArr = [log componentsSeparatedByString:@" "];
    [logArr enumerateObjectsUsingBlock:^(NSString * _Nonnull tmpStr, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([tmpStr containsString:@"cardId"]) {
            NSArray<NSString *> * _logArr = [tmpStr componentsSeparatedByString:@"="];
            if (_logArr.count >= 2) {
                NSString * _Nullable _cardId = _logArr[1];
                if (![_cardId isEqualToString:@""]) {
                    NSLog(@"%@, %@", _cardId, log);
                    *stop = YES;
                    cardId = _cardId;
                }
            }
        }
    }];

    if (cardId == nil) {
        return nil;
    }

    HSCard *card = [HSCardFactory.sharedInstance createHSCardFromCardId:cardId];
    return card;
}

@end