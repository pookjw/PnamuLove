#import <Foundation/Foundation.h>

static NSString * const kLogReaderZoneNotificationName = @"kLogReaderZoneNotificationName";

@interface LogReader : NSObject
@property (class, readonly) LogReader *sharedInstance;
- (void)startObserving;
- (void)stopObserving;
@end