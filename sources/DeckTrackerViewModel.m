#import "DeckTrackerViewModel.h"
#import "LogParser.h"
#import "HSCardFactory.h"

@implementation DeckTrackerViewModel

- (instancetype)init {
    self = [super init];

    if (self) {
        [self bind];
    }

    return self;
}

- (void)bind {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleDidStartTheGameEvent:)
                                               name:kLogParserDidStartTheGameNotificationName
                                             object:LogParser.sharedInstance];

    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleDidEndTheGameEvent:)
                                               name:kLogParserDidEndTheGameNotificationName
                                             object:LogParser.sharedInstance];

    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handlerDidRemoveCardEvent:)
                                               name:kLogParserDidRemoveCardFromDeckNotificationName
                                             object:LogParser.sharedInstance];

    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handlerDidAddCardEvent:)
                                               name:kLogParserDidAddCardToDeckNotificationName
                                             object:LogParser.sharedInstance];
}

- (void)handleDidStartTheGameEvent:(NSNotification *)notification {
    [NSNotificationCenter.defaultCenter postNotificationName:kDeckTrackerViewModelDidStartTheGameNotificationName
                                                   object:self
                                                 userInfo:nil];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self initializeDataSource];
    });
}

- (void)handleDidEndTheGameEvent:(NSNotification *)notification {
    [NSNotificationCenter.defaultCenter postNotificationName:kDeckTrackerViewModelDidEndTheGameNotificationName
                                                   object:self
                                                 userInfo:nil];
}

- (void)handlerDidRemoveCardEvent:(NSNotification *)notification {
    HSCard * _Nullable card = notification.userInfo[@"card"];
    if (card) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeCardFromDeck:card];
        });
    }
}

- (void)handlerDidAddCardEvent:(NSNotification *)notification {
    HSCard * _Nullable card = notification.userInfo[@"card"];
    if (card) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addCardToDeck:card];
        });
    }
}

- (void)initializeDataSource {
    NSArray<HSCard *> * _Nullable cards = [HSCardFactory.sharedInstance createHSCardFromLocalDeckList];

    NSDiffableDataSourceSnapshot *snapshot = [self.dataSource snapshot];

    [snapshot deleteAllItems];
    [snapshot appendSectionsWithIdentifiers:@[@0]];

    NSMutableArray<DeckTrackerCellItem *> * __block items = [@[] mutableCopy];

    [cards enumerateObjectsUsingBlock:^(HSCard *tmpCard1, NSUInteger idx1, BOOL * _Nonnull stop1) {
        DeckTrackerCellItem *tmpItem1 = [[DeckTrackerCellItem alloc] initWithCard:tmpCard1];
        
        if ([items containsObject:tmpItem1]) {
            [items enumerateObjectsUsingBlock:^(DeckTrackerCellItem *tmpItem2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                if ([tmpItem1 isEqual:tmpItem2]) {
                    *stop2 = YES;
                    tmpItem2.count += 1;
                }
            }];
        } else {
            [items addObject:tmpItem1];
        }
    }];

    [items sortUsingComparator:^NSComparisonResult(DeckTrackerCellItem * _Nonnull obj1, DeckTrackerCellItem * _Nonnull obj2) {
        return obj1.card.cost > obj2.card.cost;
    }];

    [snapshot appendItemsWithIdentifiers:[items copy]
               intoSectionWithIdentifier:@0];
    [self.dataSource applySnapshot:snapshot animatingDifferences:NO];
}

- (void)removeCardFromDeck:(HSCard *)card {
    NSDiffableDataSourceSnapshot *snapshot = [self.dataSource snapshot];
    NSArray<NSNumber *> *sections = [snapshot sectionIdentifiers];
    if (![sections containsObject:@0]) return;

    NSMutableArray<DeckTrackerCellItem *> *items = [[snapshot itemIdentifiersInSectionWithIdentifier:@0] mutableCopy];
    DeckTrackerCellItem *item = [[DeckTrackerCellItem alloc] initWithCard:card];
    
    [items enumerateObjectsUsingBlock:^(DeckTrackerCellItem *tmpItem, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([tmpItem isEqual:item]) {
            if (tmpItem.count > 1) {
                tmpItem.count -= 1;
            } else {
                [items removeObject:item];
            }
            *stop = YES;
        }
    }];
    
    [snapshot deleteSectionsWithIdentifiers:@[@0]];
    [snapshot appendSectionsWithIdentifiers:@[@0]];
    [snapshot appendItemsWithIdentifiers:[items copy] intoSectionWithIdentifier:@0];
    [self.dataSource applySnapshot:snapshot animatingDifferences:YES];
}

- (void)addCardToDeck:(HSCard *)card {
    NSDiffableDataSourceSnapshot *snapshot = [self.dataSource snapshot];
    NSArray<NSNumber *> *sections = [snapshot sectionIdentifiers];
    if (![sections containsObject:@0]) return;

    NSMutableArray<DeckTrackerCellItem *> *items = [[snapshot itemIdentifiersInSectionWithIdentifier:@0] mutableCopy];
    DeckTrackerCellItem *item = [[DeckTrackerCellItem alloc] initWithCard:card];
    
    if ([items containsObject:item]) {
        [items enumerateObjectsUsingBlock:^(DeckTrackerCellItem *tmpItem, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([tmpItem isEqual:item]) {
                tmpItem.count += 1;
            }
        }];
    } else {
        [items addObject:item];
    }
    
    [snapshot deleteSectionsWithIdentifiers:@[@0]];
    [snapshot appendSectionsWithIdentifiers:@[@0]];
    [snapshot appendItemsWithIdentifiers:[items copy] intoSectionWithIdentifier:@0];
    [self.dataSource applySnapshot:snapshot animatingDifferences:YES];
}

@end