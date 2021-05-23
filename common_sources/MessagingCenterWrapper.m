#import "MessagingCenterWrapper.h"
#import <rocketbootstrap/rocketbootstrap.h>
#import <AppSupport/CPDistributedMessagingCenter.h>

@interface MessagingCenterWrapper ()
@property CPDistributedMessagingCenter *messagingCenter;
@end

@implementation MessagingCenterWrapper

+ (MessagingCenterWrapper *)sharedInstance {
    static MessagingCenterWrapper *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [MessagingCenterWrapper new];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        [self configureCenter];
    }

    return self;
}

- (void)configureCenter {
    dispatch_sync(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        self.messagingCenter = [CPDistributedMessagingCenter centerNamed:kCPDistributedMessagingCenterName];
        rocketbootstrap_distributedmessagingcenter_apply(self.messagingCenter);
        [self.messagingCenter runServerOnCurrentThread];
    });
}

@end
