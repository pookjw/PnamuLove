#import "LocalData.h"

@interface LocalData ()
@end

@implementation LocalData
+ (LocalData *)sharedInstance {
    static LocalData *sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [LocalData new];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];

    if (self) {
        [self createBaseURLDirIfNeeded];
    }

    return self;
}

- (NSURL *)baseURL {
    return [NSURL fileURLWithPath:@"/var/mobile/Library/PnamuLove"];
}

- (NSURL *)deckListFileURL {
    return [NSURL fileURLWithPath:@"/var/mobile/Library/PnamuLove/decklist.json"];
}

- (NSURL *)allCardsFileURL {
    return [NSURL fileURLWithPath:@"/var/mobile/Library/PnamuLove/allcards.json"];
}

- (NSDictionary * _Nullable)deckListObject {
    return [self jsonObjectFor:self.deckListFileURL];
}

- (NSDictionary * _Nullable)allCardsObject {
    return [self jsonObjectFor:self.allCardsFileURL];
}

- (NSDictionary * _Nullable)jsonObjectFor:(NSURL *)url {
    if (![NSFileManager.defaultManager fileExistsAtPath:url.path]) {
        return nil;
    }

    NSData *data = [NSData dataWithContentsOfURL:url];
    NSDictionary * _Nullable dic = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];

    return dic;
}

- (void)removeDeckListFile {
    [NSFileManager.defaultManager removeItemAtURL:self.deckListFileURL error:nil];
}

- (void)removeAllCardsFile {
    [NSFileManager.defaultManager removeItemAtURL:self.allCardsFileURL error:nil];
}

- (void)removeAllFiles {
    [NSFileManager.defaultManager removeItemAtURL:self.baseURL error:nil];
    [self createBaseURLDirIfNeeded];
}

- (void)createBaseURLDirIfNeeded {
    if (![NSFileManager.defaultManager fileExistsAtPath:@""]) {
            [NSFileManager.defaultManager createDirectoryAtURL:self.baseURL withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

@end