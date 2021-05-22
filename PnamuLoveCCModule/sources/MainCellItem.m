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
        MainCellItem *compareMainCellItem = (MainCellItem *)object;
        return (self.type == compareMainCellItem.type); 
    } else {
        return NO;
    }
}

- (NSString *)title {
    switch (self.type) {
        case MainCellItemTypeEnterDeckListCode:
            return @"Enter Deck List Code";
        case MainCellItemTypeGetAllCardsFile:
            return @"Refresh All Cards file";
        default:
            return @"(unknown MainCellItemType)";
    }
}

@end