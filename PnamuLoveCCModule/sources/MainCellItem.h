#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MainCellItemType) {
    MainCellItemTypeEnterDeckListCode = 0x1,
    MainCellItemTypeGetAllCardsFile = 0x10
};

@interface MainCellItem : NSObject
@property (readonly) MainCellItemType type;
@property (nonatomic, readonly) NSString *title;
- (instancetype)initWithType:(NSUInteger)type;
- (NSString *)title;
@end