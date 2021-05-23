#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MainCellItemType) {
    MainCellItemTypeEnterDeckListCode = 0x1,
    MainCellItemTypeGetAllCardsFile = 0x10,
    MainCellItemTypeRemoveDeckListFile = 0x100,
    MainCellItemTypeRemoveAllCardsFile = 0x1000,
    MainCellItemTypeRemoveAllFiles = 0x10000
};

@interface MainCellItem : NSObject
@property (readonly) MainCellItemType type;
@property (nonatomic, readonly) NSString *title;
- (instancetype)initWithType:(NSUInteger)type;
- (NSString *)title;
@end