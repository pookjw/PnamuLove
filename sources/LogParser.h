#import <Foundation/Foundation.h>
#import "LogReader.h"

static NSString * const kLogParserDidStartTheGameNotificationName = @"kLogParserDidStartTheGameNotificationName";
static NSString * const kLogParserDidEndTheGameNotificationName = @"kLogParserDidEndTheGameNotificationName";
static NSString * const kLogParserDidRemoveCardFromDeckNotificationName = @"kLogParserDidRemoveCardFromDeckNotificationName";
static NSString * const kLogParserDidAddCardToDeckNotificationName = @"kLogParserDidAddCardToDeckNotificationName";

@interface LogParser : NSObject
@property (class, readonly) LogParser *sharedInstance;
- (instancetype)initWithLogReader:(LogReader *)logReader;
- (void)startObserving;
- (void)stopObserving;
@end