#import "AccessTokenDownloader.h"
#import "../../common_sources/Const.h"

@implementation AccessTokenDownloader

+ (AccessTokenDownloader *)sharedInstance {
    static AccessTokenDownloader *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [AccessTokenDownloader new];
    });

    return sharedInstance;
}

- (void)downloadAccessTokenWithCompletionHandler:(void (^)(NSString * _Nullable token, NSError * _Nullable error))completionHandler {
    NSURL *baseURL = [NSURL URLWithString:@"https://us.battle.net/oauth/token"];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *queryItem = [[NSURLQueryItem alloc] initWithName:@"grant_type" value:@"client_credentials"];
    components.queryItems = @[queryItem];
    NSURL *finalURL = components.URL;

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:finalURL];
    request.HTTPMethod = @"POST";
    request.allHTTPHeaderFields = @{@"Authorization": @"Basic ZDNmNDMxYmMzMjc3NDMxMWJjNGI3MzAwZDFmYTUzMTQ6Z3FWUW9VMVptY3JSZjI0ZzZVVmlVM200YnpRc1YzUEs="};

    NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];

    NSURLSessionDataTask *task = [session
                                  dataTaskWithRequest:[request copy]
                                  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil, error);
            return;
        }

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSUInteger statusCode = httpResponse.statusCode;

        if (statusCode != 200) {
            NSString *message = [NSString stringWithFormat:@"Status code is %lu at AccessTokenDownloader.", statusCode];
            NSError *error = [NSError errorWithDomain:kBundleIdentifier
                                                 code:100
                                             userInfo:@{NSLocalizedDescriptionKey: message}];
            completionHandler(nil, error);
            return;
        }

        NSError * _Nullable jsonError = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

        if (jsonError) {
            completionHandler(nil, jsonError);
            return;
        }

        NSString * _Nullable token = dic[@"access_token"];

        if (token == nil) {
            NSString *message = @"access_token is nil!";
            NSError *error = [NSError errorWithDomain:kBundleIdentifier
                                                 code:200
                                             userInfo:@{NSLocalizedDescriptionKey: message}];
            completionHandler(nil, error);
            return;
        }

        completionHandler(token, nil);
    }];

    [task resume];
    [session finishTasksAndInvalidate];
}

@end