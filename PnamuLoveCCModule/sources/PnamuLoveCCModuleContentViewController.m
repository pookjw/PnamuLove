#import "PnamuLoveCCModuleContentViewController.h"
#import "MainViewController.h"

@interface PnamuLoveCCModuleContentViewController ()
@property (weak) UIImageView *iconImageView;
@property (weak) UIViewController *contentViewController;
@end

@implementation PnamuLoveCCModuleContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureIconImageView];
    [self configureContentViewController];
    [self hideContentViewController];
}

- (void)configureIconImageView {
    UIImage *iconImage = [UIImage systemImageNamed:@"leaf"];
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:iconImage];
    self.iconImageView = iconImageView;

    [self.view addSubview:iconImageView];

    iconImageView.tintColor = UIColor.whiteColor;
    iconImageView.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [iconImageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [iconImageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [iconImageView.widthAnchor constraintEqualToConstant:40],
        [iconImageView.heightAnchor constraintEqualToConstant:40]
    ]];

    [iconImageView setHidden:YES];
}

- (void)configureContentViewController {
    MainViewController *mainVC = [MainViewController new];
    UIViewController *contentViewController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.contentViewController = contentViewController;

    [self addChildViewController:contentViewController];
    [self.view addSubview:contentViewController.view];

    contentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [contentViewController.view.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [contentViewController.view.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [contentViewController.view.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [contentViewController.view.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor]
    ]];

    [contentViewController.view setHidden:YES];
}

- (void)showContentViewController {
    [self.iconImageView setHidden:YES];
    [self.contentViewController.view setHidden:NO];
}

- (void)hideContentViewController {
    [self.iconImageView setHidden:NO];
    [self.contentViewController.view setHidden:YES];
}

#pragma mark - CCUIContentModuleContentViewController

-(BOOL)shouldExpandModuleOnTouch:(id)arg1 {
    return YES;
}

-(void)willTransitionToExpandedContentMode:(BOOL)arg1 {
    if (arg1) {
        [self showContentViewController];
    } else {
        [self hideContentViewController];
    }
}

- (double)preferredExpandedContentHeight {
    return 300;
}

@end