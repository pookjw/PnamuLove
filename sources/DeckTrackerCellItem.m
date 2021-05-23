#import "DeckTrackerCellItem.h"

@implementation DeckTrackerCellItem

- (instancetype)initWithCard:(HSCard *)card {
    self = [self init];

    if (self) {
        self.card = card;
        self.count = 1;
    }

    return self;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[DeckTrackerCellItem class]]) {
        DeckTrackerCellItem *comparisonDeckTrackerCellItem = (DeckTrackerCellItem *)object;
        return [self.card isEqual:comparisonDeckTrackerCellItem.card];
    } else {
        return [super isEqual:object];
    }
}

- (NSString *)title {
    NSString *title = [NSString stringWithFormat:@"(%lu) (x%lu) %@", self.card.cost, self.count, self.card.name];
    return title;
}

@end