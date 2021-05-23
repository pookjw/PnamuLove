#import "MainViewController.h"
#import "MainViewModel.h"
#import "UIViewController+SpinnerView.h"

@interface MainViewController () <UICollectionViewDelegate>
@property (weak, atomic) UICollectionView *collectionView;
@property MainViewModel *viewModel;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAttributes];
    [self configureCollectionView];
    [self configureViewModel];
}

- (void)setAttributes {
    self.title = @"PnamuLove";
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

    collectionView.delegate = self;
}

- (void)configureViewModel {
    MainViewModel *viewModel = [MainViewModel new];
    self.viewModel = viewModel;

    viewModel.dataSource = [self makeDataSource];
    [viewModel updateDataSource];
}

- (UICollectionViewCellRegistration *)makeCellRegistration {
    return [UICollectionViewCellRegistration registrationWithCellClass:[UICollectionViewCell class]
                                                                   configurationHandler:^(__kindof UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath, id  _Nonnull item) {
        MainCellItem *cellItem;
        if ([item isKindOfClass:[MainCellItem class]]) {
            cellItem = (MainCellItem *)item;
        } else {
            return;
        }
        UIListContentConfiguration *configuration = [UIListContentConfiguration sidebarCellConfiguration];
        configuration.text = cellItem.title;
        // configuration.secondaryText = resultItem.secondaryText;
        cell.contentConfiguration = configuration;
    }];
}

- (MainDataSource *)makeDataSource {
    MainDataSource *dataSource = [[MainDataSource alloc] initWithCollectionView:self.collectionView
                                                                   cellProvider:^UICollectionViewCell * _Nullable(UICollectionView * _Nonnull collectionView, NSIndexPath * _Nonnull indexPath, id  _Nonnull itemIdentifier) {
        UICollectionViewCell *cell = [collectionView dequeueConfiguredReusableCellWithRegistration:[self makeCellRegistration]
                                                                                      forIndexPath:indexPath
                                                                                              item:itemIdentifier];
        return cell;
    }];
    return dataSource;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.viewModel handleSelectionFor:indexPath];    
}

@end