#import <UIKit/UIKit.h>
#import <hearthstone/UnityDefaultViewController.h>
#import "LogParser.h"

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

    [LogParser.sharedInstance startObserving];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(getEvent:)
                                               name:kLogParserDidStartTheGameNotificationName
                                             object:LogParser.sharedInstance];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(getEvent:)
                                               name:kLogParserDidEndTheGameNotificationName
                                             object:LogParser.sharedInstance];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(getEvent:)
                                               name:kLogParserDidRemoveCardFromDeckNotificationName
                                             object:LogParser.sharedInstance];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(getEvent:)
                                               name:kLogParserDidAddCardToDeckNotificationName
                                             object:LogParser.sharedInstance];
}

%new
- (void)getEvent:(NSNotification *)notification {
    NSLog(@"%@, %@", notification.name, notification.userInfo);
}

%end