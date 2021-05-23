#import <UIKit/UIKit.h>
#import "DeckTrackerCellItem.h"

typedef UICollectionViewDiffableDataSource<NSNumber *, DeckTrackerCellItem *> DeckTrackerDataSource;

static NSString * const kDeckTrackerViewModelDidStartTheGameNotificationName = @"kDeckTrackerViewModelDidStartTheGameNotificationName";
static NSString * const kDeckTrackerViewModelDidEndTheGameNotificationName = @"kDeckTrackerViewModelDidEndTheGameNotificationName";

@interface DeckTrackerViewModel : NSObject
@property DeckTrackerDataSource *dataSource;
@end