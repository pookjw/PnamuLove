#import "PnamuLoveCCModule.h"
#import "PnamuLoveCCModuleContentViewController.h"

@implementation PnamuLoveCCModule
-(UIViewController*)contentViewController {
    return [PnamuLoveCCModuleContentViewController new];
}
@end