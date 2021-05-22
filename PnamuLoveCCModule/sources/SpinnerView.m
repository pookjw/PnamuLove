#import "SpinnerView.h"

@interface SpinnerView ()
@property (weak) UIVisualEffectView *visualEffectView;
@property (weak) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation SpinnerView

- (instancetype)init {
    self = [super init];

    if (self) {
        [self setAttributes];
        [self configureVisualEffectView];
        [self configureActivityIndicatorView];
        [self traitCollectionDidChange:nil];
    }

    return self;
}

- (void)setAttributes {
    self.backgroundColor = UIColor.clearColor;
    self.userInteractionEnabled = YES;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    [self.activityIndicatorView stopAnimating];
    
    switch (self.traitCollection.userInterfaceStyle) {
        case UIUserInterfaceStyleLight:
            self.visualEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            self.activityIndicatorView.color = UIColor.whiteColor;
            break;
        case UIUserInterfaceStyleDark:
            self.visualEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            self.activityIndicatorView.color = UIColor.blackColor;
            break;
        default:
            self.visualEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            self.activityIndicatorView.color = UIColor.whiteColor;
            break;
    }
    
    [self.activityIndicatorView startAnimating];
}

- (void)configureVisualEffectView {
    UIVisualEffectView *visualEffectView = [UIVisualEffectView new];
    self.visualEffectView = visualEffectView;
    
    [self addSubview:visualEffectView];
    
    visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [visualEffectView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [visualEffectView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
        [visualEffectView.widthAnchor constraintEqualToConstant:75],
        [visualEffectView.heightAnchor constraintEqualToConstant:75]
    ]];
    visualEffectView.layer.cornerRadius = 10;
    visualEffectView.clipsToBounds = YES;
    visualEffectView.userInteractionEnabled = NO;
}

- (void)configureActivityIndicatorView {
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityIndicatorView = activityIndicatorView;
    
    [self addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [activityIndicatorView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [activityIndicatorView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
    ]];
    activityIndicatorView.backgroundColor = UIColor.clearColor;
    activityIndicatorView.userInteractionEnabled = NO;
}

@end
