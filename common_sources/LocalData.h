#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalData : NSObject
@property (class, readonly) LocalData *sharedInstance;
@property (readonly) NSURL *baseURL;
@property (readonly) NSURL *deckListFileURL;
@property (readonly) NSURL *allCardsFileURL;
@property (readonly) NSDictionary * _Nullable deckListObject;
@property (readonly) NSDictionary * _Nullable allCardsObject;
@end

NS_ASSUME_NONNULL_END