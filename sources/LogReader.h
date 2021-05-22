#import <Foundation/Foundation.h>

static NSString * const kLogReaderZoneNotificationName = @"kLogReaderZoneNotificationName";

@interface LogReader : NSObject
+ (instancetype)sharedInstance;
- (void)startObserving;
- (void)stopObserving;
@end