#import <Foundation/Foundation.h>
#import "HSCard.h"

@interface DeckTrackerCellItem : NSObject
@property HSCard *card;
@property NSUInteger count;
@property (nonatomic, readonly) NSString *title;
- (instancetype)initWithCard:(HSCard *)card;
@end
