#import "PnamuLoveCCModule.h"
#import "PnamuLoveCCModuleContentViewController.h"
#import "../../common_sources/MessagingCenterWrapper.h"

@implementation PnamuLoveCCModule

- (instancetype)init {
    self = [super init];

    if (self) {
        
    }

    return self;
}

-(UIViewController*)contentViewController {
    return [PnamuLoveCCModuleContentViewController new];
}

@end