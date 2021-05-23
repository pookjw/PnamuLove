#import <Foundation/Foundation.h>
#import "HSCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSCardFactory : NSObject
@property (class, readonly) HSCardFactory *sharedInstance;
- (HSCard * _Nullable)createHSCardFromCardId:(NSString *)cardId;
- (HSCard * _Nullable)createHSCardFromDbfId:(NSString *)dbfId;
- (NSArray<HSCard *> * _Nullable)createHSCardFromLocalDeckList;
- (void)refreshDeckListObjectCache;
@end

NS_ASSUME_NONNULL_END