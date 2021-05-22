#import "MainViewModel.h"

@implementation MainViewModel

- (void)updateDataSource {
    NSDiffableDataSourceSnapshot *snapshot = [self.dataSource snapshot];
    NSNumber *firstSection = @0;

    [snapshot deleteAllItems];
    [snapshot appendSectionsWithIdentifiers:@[firstSection]];

    NSArray<MainCellItem *> *items = @[
        [[MainCellItem alloc] initWithType:MainCellItemTypeEnterDeckListCode],
        [[MainCellItem alloc] initWithType:MainCellItemTypeGetAllCardsFile]
    ];

    [snapshot appendItemsWithIdentifiers:items
               intoSectionWithIdentifier:firstSection];
    [self.dataSource applySnapshot:snapshot animatingDifferences:NO];
}

@end