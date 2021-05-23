#import <UIKit/UIKit.h>
#import "MainCellItem.h"

typedef UICollectionViewDiffableDataSource<NSNumber *, MainCellItem *> MainDataSource;
static NSString * const kMainViewModelDidFetchDeckListNotificationName = @"kMainViewModelDidFetchDeckListNotificationName";
static NSString * const kMainViewModelDidGetAllCardsFileNotificationName = @"kMainViewModelDidGetAllCardsFileNotificationName";

@interface MainViewModel : NSObject
@property MainDataSource *dataSource;
- (void)updateDataSource;
- (void)handleSelectionFor:(NSIndexPath *)indexPath;
@end