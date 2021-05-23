#import "DeckTrackerViewModel.h"
#import "LogParser.h"

@implementation DeckTrackerViewModel

- (instancetype)init {
    self = [super init];

    if (self) {
        [self bind];
    }

    return self;
}

- (void)bind {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleDidStartTheGameEvent:)
                                               name:kLogParserDidStartTheGameNotificationName
                                             object:LogParser.sharedInstance];

    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleDidEndTheGameEvent:)
                                               name:kLogParserDidEndTheGameNotificationName
                                             object:LogParser.sharedInstance];
}

- (void)handleDidStartTheGameEvent:(NSNotification *)notification {
    [NSNotificationCenter.defaultCenter postNotificationName:kDeckTrackerViewModelDidStartTheGameNotificationName
                                                   object:self
                                                 userInfo:nil];
}

- (void)handleDidEndTheGameEvent:(NSNotification *)notification {
    [NSNotificationCenter.defaultCenter postNotificationName:kDeckTrackerViewModelDidEndTheGameNotificationName
                                                   object:self
                                                 userInfo:nil];
}

@end