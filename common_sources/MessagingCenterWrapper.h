#import <Foundation/Foundation.h>

static NSString * const kCPDistributedMessagingCenterName = @"com.pookjw.pnamulovemessagingcenter";

@interface MessagingCenterWrapper : NSObject
@property (class, readonly) MessagingCenterWrapper *sharedInstance;
@end