#import <UIKit/UIKit.h>
#import <hearthstone/UnityDefaultViewController.h>
#import "LogReader.h"

%hook UIViewController
- (void)viewDidAppear:(BOOL)animated {
	%orig(animated);
	NSLog(@"pnamulove Hello!");

	UIView *testView = [UIView new];
    testView.backgroundColor = UIColor.redColor;
    testView.translatesAutoresizingMaskIntoConstraints = NO;
    testView.userInteractionEnabled = NO;
    [self.view addSubview:testView];
    [NSLayoutConstraint activateConstraints:@[
        [testView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [testView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [testView.widthAnchor constraintEqualToConstant:100],
        [testView.heightAnchor constraintEqualToConstant:100]
    ]];

    [[LogReader sharedInstance] startObserving];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(getEvent:)
                                               name:LogReaderZoneNotificationName
                                             object:[LogReader sharedInstance]];
}

%new
- (void)getEvent:(NSDictionary *)userInfo {
    NSLog(@"%@", userInfo);
}

%end