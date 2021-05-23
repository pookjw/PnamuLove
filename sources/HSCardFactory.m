#import "HSCardFactory.h"
#import "../common_sources/LocalData.h"

@interface HSCardFactory ()
@property NSDictionary * _Nullable allCardsObject;
@property NSDictionary * _Nullable deckListObject;
@end

@implementation HSCardFactory

+ (HSCardFactory *)sharedInstance {
    static HSCardFactory *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [HSCardFactory new];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        [self refreshDeckListObjectCache];
        [self refresAllCardsObjectCache];
    }

    return self;
}

- (HSCard * _Nullable)createHSCardFromCardId:(NSString *)cardId {
    return [self createHSCardFromDicKey:@"cardId" value:cardId];
}

- (HSCard * _Nullable)createHSCardFromDbfId:(NSString *)dbfId {
    return [self createHSCardFromDicKey:@"dbfId" value:dbfId];
}

- (NSArray<HSCard *> * _Nullable)createHSCardFromLocalDeckList {
    NSMutableArray<HSCard *> * __block results = [@[] mutableCopy];
    NSArray<NSDictionary *> *cards = self.deckListObject[@"cards"];

    [cards enumerateObjectsUsingBlock:^(NSDictionary *tmpCardDic, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *tmpId = [(NSNumber *)tmpCardDic[@"id"] stringValue];
        HSCard * _Nullable tmpCard = [self createHSCardFromDbfId:tmpId];
        if (tmpCard) {
            [results addObject:tmpCard];
        }
    }];

    if (results.count == 0) {
        return nil;
    } else {
        return [results copy];
    }
}

- (void)refreshDeckListObjectCache {
    self.deckListObject = LocalData.sharedInstance.deckListObject;
}

- (void)refresAllCardsObjectCache {
    self.allCardsObject = LocalData.sharedInstance.allCardsObject;
}

- (HSCard *)convertToHSCardFromAllCardsDic:(NSDictionary *)dic {
    return [[HSCard alloc] initWithCardId:dic[@"cardId"]
                                    dbfId:dic[@"dbfId"]
                                     name:dic[@"name"]
                                     cost:[(NSNumber *)dic[@"cost"] unsignedIntegerValue]];
}

- (HSCard * _Nullable)createHSCardFromDicKey:(NSString *)key
                                       value:(NSString *)value {
    NSDictionary * __block _Nullable card = nil;
    [self.allCardsObject enumerateKeysAndObjectsUsingBlock:^(NSString *tmpCardSet, id tmpCards, BOOL * _Nonnull stop1) {
        if (![tmpCards isKindOfClass:[NSArray class]]) return;
        [tmpCards enumerateObjectsUsingBlock:^(NSDictionary *tmpCard, NSUInteger idx, BOOL * _Nonnull stop2) {
            NSString *tmpValue1;
            id tmpValue2 = tmpCard[key];

            if ([tmpValue2 isKindOfClass:[NSString class]]) {
                tmpValue1 = tmpValue2;
            } else if ([tmpValue2 isKindOfClass:[NSNumber class]]) {
                tmpValue1 = [tmpValue2 stringValue];
            }

            if ([value isEqualToString:tmpValue1]) {
                *stop1 = YES;
                *stop2 = YES;
                card = tmpCard;
            }
        }];
    }];

    if (card) {
        return [self convertToHSCardFromAllCardsDic:card];
    } else {
        return nil;
    }
}

@end