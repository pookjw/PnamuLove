#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Alert)
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString * _Nullable)message;
- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString * _Nullable)message
textFieldCompletionHandler:(void (^)(NSString * _Nullable string))completionHandler;
@end

NS_ASSUME_NONNULL_END
