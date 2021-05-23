#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString * _Nullable)message {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alertController addAction:doneAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showAlertWithTitle:(NSString *)title
                   message:(NSString * _Nullable)message
textFieldCompletionHandler:(void (^)(NSString * _Nullable string))completionHandler {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {}];
    
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           NSString * _Nullable text = alertController.textFields.firstObject.text;
                                                           completionHandler(text);
                                                       }];
    
    [alertController addAction:doneAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
