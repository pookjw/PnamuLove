#import "DeckTrackerViewController.h"
#import "DeckTrackerViewModel.h"

@interface DeckTrackerViewController ()
@property (weak) UICollectionView *collectionView;
@property (weak) UIButton *toggleHiddenButton;
@property DeckTrackerViewModel *viewModel;
@end

@implementation DeckTrackerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAttributes];
    [self configureCollectionView];
    [self configureToggleHiddenButton];
    [self configureViewModel];
    [self bind];
}

- (void)setAttributes {
    self.view.backgroundColor = UIColor.clearColor;
    self.view.layer.opacity = 0.75;
    self.view.hidden = YES;
}

- (void)configureViewModel {
    DeckTrackerViewModel *viewModel = [DeckTrackerViewModel new];
    self.viewModel = viewModel;

    viewModel.dataSource = [self makeDataSource];
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

- (void)configureCollectionView {
    UICollectionLayoutListConfiguration *layoutConfiguration = [[UICollectionLayoutListConfiguration alloc] initWithAppearance:UICollectionLayoutListAppearanceInsetGrouped];
    UICollectionViewCompositionalLayout *layout = [UICollectionViewCompositionalLayout layoutWithListConfiguration:layoutConfiguration];

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];

    collectionView.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
    ]];
}

- (UICollectionViewCellRegistration *)makeCellRegistration {
    return [UICollectionViewCellRegistration registrationWithCellClass:[UICollectionViewCell class]
                                                                   configurationHandler:^(__kindof UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, id  _Nonnull item) {
        DeckTrackerCellItem *cellItem;
        if ([item isKindOfClass:[DeckTrackerCellItem class]]) {
            cellItem = (DeckTrackerCellItem *)item;
        } else {
            return;
        }
        UIListContentConfiguration *configuration = [UIListContentConfiguration sidebarCellConfiguration];
        configuration.text = cellItem.title;
        cell.contentConfiguration = configuration;
    }];
}

- (DeckTrackerDataSource *)makeDataSource {
    DeckTrackerDataSource *dataSource = [[DeckTrackerDataSource alloc] initWithCollectionView:self.collectionView
                                                                   cellProvider:^UICollectionViewCell * _Nullable(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, id  _Nonnull itemIdentifier) {
        UICollectionViewCell *cell = [collectionView dequeueConfiguredReusableCellWithRegistration:[self makeCellRegistration]
                                                                                      forIndexPath:indexPath
                                                                                              item:itemIdentifier];
        return cell;
    }];
    return dataSource;
}

- (void)configureToggleHiddenButton {
    __weak typeof(self) weakSelf = self;

    UIAction *action = [UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        if (weakSelf.collectionView.hidden) {
            weakSelf.collectionView.hidden = NO;
        } else {
            weakSelf.collectionView.hidden = YES;
        }
    }];

    UIButton *toggleHiddenButton = [[UIButton alloc] initWithFrame:CGRectZero primaryAction:action];
    self.toggleHiddenButton = toggleHiddenButton;

    toggleHiddenButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:toggleHiddenButton];
    [NSLayoutConstraint activateConstraints:@[
        [toggleHiddenButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [toggleHiddenButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor]
    ]];

    [toggleHiddenButton setTitle:@"Toggle" forState:UIControlStateNormal];
    [toggleHiddenButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    toggleHiddenButton.backgroundColor = UIColor.blackColor;
}

@end