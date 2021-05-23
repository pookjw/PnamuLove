#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllCardsDownloader : NSObject
@property (class, readonly) AllCardsDownloader *sharedInstance;
- (void)downloadAllCardsWithErrorHandler:(void (^)(NSError * _Nullable error))errorHandler;
@end

NS_ASSUME_NONNULL_END