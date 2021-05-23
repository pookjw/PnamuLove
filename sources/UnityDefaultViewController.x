#import <hearthstone/UnityDefaultViewController.h>
#import "DeckTrackerViewController.h"

static __weak DeckTrackerViewController *deckTrackerViewController = nil;

%hook UnityDefaultViewController
- (void)viewDidAppear:(BOOL)animated {
	%orig(animated);
    [self performSelector:@selector(addDeckTrackerViewControllerIfNeeded)];
}

%new
- (void)addDeckTrackerViewControllerIfNeeded {
    if (deckTrackerViewController) return;

    DeckTrackerViewController *_deckTrackerViewController = [DeckTrackerViewController new];
    deckTrackerViewController = _deckTrackerViewController;
    [self addChildViewController:_deckTrackerViewController];

    UIView *deckTrackerView = _deckTrackerViewController.view;
    [self.view addSubview:deckTrackerView];
    deckTrackerView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [deckTrackerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [deckTrackerView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [deckTrackerView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [deckTrackerView.widthAnchor constraintEqualToConstant:300]
    ]];
}

%end