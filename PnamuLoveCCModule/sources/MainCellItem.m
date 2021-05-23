#import "MainCellItem.h"

@implementation MainCellItem

- (instancetype)init {
    self = [super init];

    if (self) {
        _type = 0;
    }

    return self;
}

- (instancetype)initWithType:(NSUInteger)type {
    self = [self init];

    if (self) {
        _type = type;
    }

    return self;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[MainCellItem class]]) {
        MainCellItem *comparisonMainCellItem = (MainCellItem *)object;
        return (self.type == comparisonMainCellItem.type); 
    } else {
        return [super isEqual:object];
    }
}

- (NSString *)title {
    switch (self.type) {
        case MainCellItemTypeEnterDeckListCode:
            return @"Enter Deck List Code";
        case MainCellItemTypeGetAllCardsFile:
            return @"Download All Cards File";
        case MainCellItemTypeRemoveDeckListFile:
            return @"Remove Deck List File";
        case MainCellItemTypeRemoveAllCardsFile:
            return @"Remove All Cards File";
        case MainCellItemTypeRemoveAllFiles:
            return @"Remove All Files";
        default:
            return @"(unknown MainCellItemType)";
    }
}

@end