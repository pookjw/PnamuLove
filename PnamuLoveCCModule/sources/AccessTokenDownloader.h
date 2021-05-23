#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccessTokenDownloader : NSObject
@property (class, readonly) AccessTokenDownloader *sharedInstance;
- (void)downloadAccessTokenWithCompletionHandler:(void (^)(NSString * _Nullable token, NSError * _Nullable error))completionHandler;
@end

NS_ASSUME_NONNULL_END