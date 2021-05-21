#import <Foundation/Foundation.h>

static NSString * const LogReaderZoneNotificationName = @"LogReaderZoneNotificationName";

@interface LogReader : NSObject
+ (instancetype)sharedInstance;
- (void)startObserving;
@end