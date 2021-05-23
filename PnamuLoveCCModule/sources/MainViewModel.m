#import "MainViewModel.h"
#import "DeckListDownloader.h"

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

- (void)handleSelectionFor:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        default:
            break;
    }

    [DeckListDownloader.sharedInstance downloadDeckListFromCode:@"AAEBAa0GHrkG9xPDFoO7Are7Arq7Ati7Auq/AtHBAvDPAujQApDTAsvmApeHA+aIA/yjA5mpA/KsA4GxA5GxA5O6A9fOA/bWA+LeA/vfA/jjA8GfBJegBKGgBKigBAAA" errorHandler:^(NSError * _Nullable error){
        NSLog(@"%@", error.localizedDescription);
    }];
}

@end