#import "MainViewModel.h"
#import "../../common_sources/LocalData.h"
#import "DeckListDownloader.h"
#import "AllCardsDownloader.h"

@implementation MainViewModel

- (MainCellItem * _Nullable)cellItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<NSNumber *> *sections = self.dataSource.snapshot.sectionIdentifiers;
    if (sections.count <= indexPath.section) return nil;
    NSNumber *section = sections[indexPath.section];
    NSArray *cellItems = [self.dataSource.snapshot itemIdentifiersInSectionWithIdentifier:section];
    if (cellItems.count <= indexPath.row) return nil;
    return cellItems[indexPath.row];
}

- (void)updateDataSource {
    NSDiffableDataSourceSnapshot *snapshot = [self.dataSource snapshot];
    NSNumber *firstSection = @0;

    [snapshot deleteAllItems];
    [snapshot appendSectionsWithIdentifiers:@[firstSection]];

    NSArray<MainCellItem *> *items = @[
        [[MainCellItem alloc] initWithType:MainCellItemTypeEnterDeckListCode],
        [[MainCellItem alloc] initWithType:MainCellItemTypeGetAllCardsFile],
        [[MainCellItem alloc] initWithType:MainCellItemTypeRemoveDeckListFile],
        [[MainCellItem alloc] initWithType:MainCellItemTypeRemoveAllCardsFile],
        [[MainCellItem alloc] initWithType:MainCellItemTypeRemoveAllFiles]
    ];

    [snapshot appendItemsWithIdentifiers:items
               intoSectionWithIdentifier:firstSection];
    [self.dataSource applySnapshot:snapshot animatingDifferences:NO];
}

- (void)downloadAllCardsWithErrorHandler:(void (^)(NSError * _Nullable error))errorHandler {
    [AllCardsDownloader.sharedInstance downloadAllCardsWithErrorHandler:errorHandler];
}

- (void)downloadDeckListFromCode:(NSString *)deckListCode
                    errorHandler:(void (^)(NSError * _Nullable error))errorHandler {
    [DeckListDownloader.sharedInstance downloadDeckListFromCode:deckListCode errorHandler:errorHandler];
}

- (void)removeDeckListFile {
    [LocalData.sharedInstance removeDeckListFile];
}

- (void)removeAllCardsFile {
    [LocalData.sharedInstance removeAllCardsFile];
}

- (void)removeAllFiles {
    [LocalData.sharedInstance removeAllFiles];
}

- (void)handleSelectionFor:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        default:
            break;
    }

    [DeckListDownloader.sharedInstance downloadDeckListFromCode:@"AAEBAa0GHrkG9xPDFoO7Are7Arq7Ati7Auq/AtHBAvDPAujQApDTAsvmApeHA+aIA/yjA5mpA/KsA4GxA5GxA5O6A9fOA/bWA+LeA/vfA/jjA8GfBJegBKGgBKigBAAA" errorHandler:^(NSError * _Nullable error){
        NSLog(@"%@", error.localizedDescription);
    }];

    [AllCardsDownloader.sharedInstance downloadAllCardsWithErrorHandler:^(NSError * _Nullable error){
        NSLog(@"%@", error.localizedDescription);
    }];
}

@end