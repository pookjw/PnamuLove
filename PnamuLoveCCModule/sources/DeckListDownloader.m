#import "DeckListDownloader.h"
#import "../../common_sources/LocalData.h"
#import "AccessTokenDownloader.h"
#import "../../common_sources/Const.h"

@interface DeckListDownloader ()
@end

@implementation DeckListDownloader

+ (DeckListDownloader *)sharedInstance {
    static DeckListDownloader *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [DeckListDownloader new];
    });

    return sharedInstance;
}

- (void)downloadDeckListFromCode:(NSString *)deckListCode
                    errorHandler:(void (^)(NSError * _Nullable error))errorHandler {
    [AccessTokenDownloader.sharedInstance downloadAccessTokenWithCompletionHandler:^(NSString * _Nullable token, NSError * _Nullable error) {
        NSURL *baseURL = [NSURL URLWithString:@"https://us.api.blizzard.com/hearthstone/deck"];
        NSURLComponents *components = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:YES];
        NSURLQueryItem *queryItem1 = [[NSURLQueryItem alloc] initWithName:@"locale" value:@"en_US"];
        NSURLQueryItem *queryItem2 = [[NSURLQueryItem alloc] initWithName:@"code" value:deckListCode];
        NSURLQueryItem *queryItem3 = [[NSURLQueryItem alloc] initWithName:@"access_token" value:token];
        components.queryItems = @[queryItem1, queryItem2, queryItem3];
        NSURL *finalURL = components.URL;

        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:finalURL];
        request.HTTPMethod = @"GET";

        NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];

        NSURLSessionDataTask *task = [session
                                  dataTaskWithRequest:[request copy]
                                  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                errorHandler(error);
                return;
            }

            NSLog(@"%@",  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSUInteger statusCode = httpResponse.statusCode;

            if (statusCode != 200) {
                NSString *message = [NSString stringWithFormat:@"Status code is %lu at DeckListDownloader.", statusCode];
                NSError *error = [NSError errorWithDomain:kBundleIdentifier
                                                    code:100
                                                userInfo:@{NSLocalizedDescriptionKey: message}];
                errorHandler(error);
                return;
            }

            NSError * _Nullable writeError = nil;
            NSURL * deckListFileURL = LocalData.sharedInstance.deckListFileURL;
            [data writeToURL:deckListFileURL options:NSDataWritingAtomic error:&writeError];

            if (writeError) {
                errorHandler(writeError);
                return;
            }

            NSLog(@"Success!");
            errorHandler(nil);
        }];

        [task resume];
        [session finishTasksAndInvalidate];
    }];
}

@end