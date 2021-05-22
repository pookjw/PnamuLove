#import "UIViewController+SpinnerView.h"
#import "SpinnerView.h"

@implementation UIViewController (SpinnerView)

- (UIView *)addSpinnerView {
    SpinnerView *spinnerView = [SpinnerView new];

    [self.view addSubview:spinnerView];

    spinnerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [spinnerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [spinnerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [spinnerView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [spinnerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];

    return spinnerView;
}

- (void)removeAllSpinnerview {
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:[SpinnerView class]]) {
            [subview removeFromSuperview];
        }
    }
}

@end
