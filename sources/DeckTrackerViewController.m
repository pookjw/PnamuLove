#import "DeckTrackerViewController.h"
#import "DeckTrackerViewModel.h"

@interface DeckTrackerViewController ()
@property DeckTrackerViewModel *viewModel;
@end

@implementation DeckTrackerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAttributes];
    [self configureViewModel];
    [self bind];
}

- (void)setAttributes {
    self.view.backgroundColor = UIColor.redColor;
    self.view.hidden = YES;
}

- (void)configureViewModel {
    DeckTrackerViewModel *viewModel = [DeckTrackerViewModel new];
    self.viewModel = viewModel;
}

- (void)bind {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleDidStartTheGameEvent:)
                                               name:kDeckTrackerViewModelDidStartTheGameNotificationName
                                             object:self.viewModel];

    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleDidEndTheGameEvent:)
                                               name:kDeckTrackerViewModelDidEndTheGameNotificationName
                                             object:self.viewModel];
}

- (void)handleDidStartTheGameEvent:(NSNotification *)notification {
    NSLog(@"handleDidStartTheGameEvent");
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.hidden = NO;
    });
}

- (void)handleDidEndTheGameEvent:(NSNotification *)notification {
    NSLog(@"handleDidEndTheGameEvent");
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.hidden = YES;
    });
}

@end