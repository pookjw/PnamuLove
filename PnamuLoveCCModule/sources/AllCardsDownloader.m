#import "AllCardsDownloader.h"
#import "../../common_sources/LocalData.h"
#import "../../common_sources/Const.h"

@interface AllCardsDownloader ()
@end

@implementation AllCardsDownloader

+ (AllCardsDownloader *)sharedInstance {
    static AllCardsDownloader *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [AllCardsDownloader new];
    });

    return sharedInstance;
}

- (void)downloadAllCardsWithErrorHandler:(void (^)(NSError * _Nullable error))errorHandler {
    NSURL *url = [NSURL URLWithString:@"https://omgvamp-hearthstone-v1.p.rapidapi.com/cards"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    request.allHTTPHeaderFields = @{@"x-rapidapi-key": @"67a008d3f9msh3351233e47c1b5bp159b64jsn09e0f31543cf"};

    NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];

    NSURLSessionDataTask *task = [session
                                  dataTaskWithRequest:[request copy]
                                  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            errorHandler(error);
            return;
        }

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSUInteger statusCode = httpResponse.statusCode;

        if (statusCode != 200) {
            NSString *message = [NSString stringWithFormat:@"Status code is %lu at AllCardsDownloader.", statusCode];
            NSError *error = [NSError errorWithDomain:kBundleIdentifier
                                                code:100
                                            userInfo:@{NSLocalizedDescriptionKey: message}];
            errorHandler(error);
            return;
        }

        NSError * _Nullable writeError = nil;
        NSURL * allCardsFileURL = LocalData.sharedInstance.allCardsFileURL;
        [data writeToURL:allCardsFileURL options:NSDataWritingAtomic error:&writeError];

        if (writeError) {
            errorHandler(writeError);
            return;
        }

        NSLog(@"Success!");
        errorHandler(nil);
    }];

    [task resume];
    [session finishTasksAndInvalidate];
}

@end