#import <hearthstone/UnityDefaultViewController.h>

%hook UnityDefaultViewController
- (void)viewDidAppear:(BOOL)animated {
	%orig(animated);

	UIView *testView = [UIView new];
    testView.backgroundColor = UIColor.redColor;
    testView.translatesAutoresizingMaskIntoConstraints = NO;
    testView.userInteractionEnabled = NO;
    testView.layer.opacity = 0.5;
    [self.view addSubview:testView];
    [NSLayoutConstraint activateConstraints:@[
        [testView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [testView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [testView.widthAnchor constraintEqualToConstant:100],
        [testView.heightAnchor constraintEqualToConstant:100]
    ]];
}
%end