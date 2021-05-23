#import "HSCard.h"

@implementation HSCard

- (instancetype)initWithCardId:(NSString *)cardId
                         dbfId:(NSString *)dbfId
                          name:(NSString *)name
                          cost:(NSInteger)cost {
    self = [self init];

    if (self) {
        self->_cardId = cardId;
        self->_dbfId = dbfId;
        self->_name = name;
        self->_cost = cost;
    }

    return self;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[HSCard class]]) {
        HSCard *comparisionHSCard = (HSCard *)object;
        return self.cardId == comparisionHSCard.cardId;
    } else {
        return [super isEqual:object];
    }
}

@end