#import <UIKit/UIKit.h>
#import "MainCellItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef UICollectionViewDiffableDataSource<NSNumber *, MainCellItem *> MainDataSource;

@interface MainViewModel : NSObject
@property MainDataSource *dataSource;
- (MainCellItem * _Nullable)cellItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)updateDataSource;
- (void)downloadAllCardsWithErrorHandler:(void (^)(NSError * _Nullable error))errorHandler;
- (void)downloadDeckListFromCode:(NSString *)deckListCode
                    errorHandler:(void (^)(NSError * _Nullable error))errorHandler;
- (void)removeDeckListFile;
- (void)removeAllCardsFile;
- (void)removeAllFiles;
@end

NS_ASSUME_NONNULL_END