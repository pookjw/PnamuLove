#import <Foundation/Foundation.h>

static NSString * const kLogReaderNewLogNotificationName = @"kLogReaderNewLogNotificationName";

@interface LogReader : NSObject
@property (class, readonly) LogReader *sharedInstance;
@property (readonly) NSURL *logsURL;
- (void)startObserving;
- (void)stopObserving;
@end