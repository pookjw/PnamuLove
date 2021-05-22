#import <UIKit/UIKit.h>
#import "MainCellItem.h"

typedef UICollectionViewDiffableDataSource<NSNumber *, MainCellItem *> MainDataSource;

@interface MainViewModel : NSObject
@property MainDataSource *dataSource;
- (void)updateDataSource;
@end