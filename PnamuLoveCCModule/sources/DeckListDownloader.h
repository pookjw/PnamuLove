#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeckListDownloader : NSObject
@property (class, readonly) DeckListDownloader *sharedInstance;
- (void)downloadDeckListFromCode:(NSString *)deckListCode
                    errorHandler:(void (^)(NSError * _Nullable error))errorHandler;
@end

NS_ASSUME_NONNULL_END