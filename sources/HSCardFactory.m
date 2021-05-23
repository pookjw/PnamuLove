#import "HSCardFactory.h"
#import "../common_sources/LocalData.h"

@interface HSCardFactory ()
@property NSDictionary * _Nullable allCardsObject;
@property NSDictionary * _Nullable deckListObject;
@end

@implementation HSCardFactory

+ (HSCardFactory *)sharedInstance {
    static HSCardFactory *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [HSCardFactory new];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        [self refreshDeckListObjectCache];
        [self refresAllCardsObjectCache];
    }

    return self;
}

- (HSCard * _Nullable)createHSCardFromCardId:(NSString *)cardId {
    NSDictionary * __block _Nullable card = nil;
    [self.allCardsObject enumerateKeysAndObjectsUsingBlock:^(NSString *tmpCardSet, id tmpCards, BOOL * _Nonnull stop1) {
        if (![tmpCards isKindOfClass:[NSArray class]]) return;
        [tmpCards enumerateObjectsUsingBlock:^(NSDictionary *tmpCard, NSUInteger idx, BOOL * _Nonnull stop2) {
            NSString *tmpCardId = tmpCard[@"cardId"];
            if ([cardId isEqualToString:tmpCardId]) {
                *stop1 = YES;
                *stop2 = YES;
                card = tmpCard;
            }
        }];
    }];

    if (card) {
        return [self convertToHSCardFromAllCardsDic:card];
    } else {
        return nil;
    }
}

- (HSCard * _Nullable)createHSCardFromDbfId:(NSString *)dbfId {
    return nil;
}

- (NSArray<HSCard *> * _Nullable)createHSCardFromLocalDeckList {
    return nil;
}

- (void)refreshDeckListObjectCache {
    self.deckListObject = LocalData.sharedInstance.deckListObject;
}

- (void)refresAllCardsObjectCache {
    self.allCardsObject = LocalData.sharedInstance.allCardsObject;
}

- (HSCard *)convertToHSCardFromAllCardsDic:(NSDictionary *)dic {
    return [[HSCard alloc] initWithCardId:dic[@"cardId"]
                                    dbfId:dic[@"dbfId"]
                                     name:dic[@"name"]
                                     cost:[(NSNumber *)dic[@"cost"] integerValue]];
}

@end