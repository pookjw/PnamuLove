#import "LogReader.h"

@interface LogReader ()
@property (weak) NSTimer *readTimer;
@property NSArray<NSString *> *prevZoneLogArr;
@property NSArray<NSString *> *prevLoadingScreenLogArr;
@end

@implementation LogReader

+ (LogReader *)sharedInstance {
    static LogReader *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [LogReader new];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.readTimer = nil;
        self.prevZoneLogArr = @[];
        self.prevLoadingScreenLogArr = @[];
    }
    
    return self;
}

- (void)startObserving {
    if (self.readTimer) {
        NSLog(@"Already observing!");
        return;
    }

    NSLog(@"Starting LogReader...");
    
    self.readTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                             target:self
                                           selector:@selector(sendLogEvent)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)stopObserving {
    [self.readTimer invalidate];
}

- (NSURL *)logsURL {
    NSURL *documentURL = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSURL *logsURL = [documentURL URLByAppendingPathComponent:@"Logs"];
    return logsURL;
}

- (void)sendLogEvent {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSArray<NSString *> *newLogArrayOfZone = [self newLogArrayOfZoneAndSavePrev];
        NSArray<NSString *> *newLogArrayOfLoadingScreen = [self newLogArrayOfLoadingScreenAndSavePrev];
        
        NSMutableArray<NSString *> *allNewLogs = [@[] mutableCopy];
        [allNewLogs addObjectsFromArray:newLogArrayOfZone];
        [allNewLogs addObjectsFromArray:newLogArrayOfLoadingScreen];

        for (NSString *log in allNewLogs) {
            [NSNotificationCenter.defaultCenter postNotificationName:kLogReaderNewLogNotificationName
                                                   object:self
                                                 userInfo:@{@"log": log}];
        }
    });
}

- (NSArray<NSString *> *)logArrayOf:(NSString *)name {
    NSURL *logURL = [[self.logsURL URLByAppendingPathComponent:name] URLByAppendingPathExtension:@"log"];
    NSData *logData = [NSData dataWithContentsOfURL:logURL];
    NSString *logStr = [[NSString alloc] initWithData:logData encoding:NSUTF8StringEncoding];
    NSArray<NSString *> *logArr = [logStr componentsSeparatedByString:@"\n"];
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *str,
                                                                   NSDictionary<NSString *,id> * _Nullable bindings) {
        return ![str isEqualToString:@""];
    }];
    NSArray *filteredLogArr = [logArr filteredArrayUsingPredicate:predicate];
    
    if (filteredLogArr == nil) return @[];
    
    return filteredLogArr;
}

- (NSArray<NSString *> *)newLogArrayOfZoneAndSavePrev {
    NSArray<NSString *> * zoneLogArr = [self logArrayOf:@"Zone"];
    NSUInteger loc = self.prevZoneLogArr.count;
    NSUInteger len = zoneLogArr.count - loc;
    
    if (len <= 0) return @[];
    
    NSRange newZoneLogRange = NSMakeRange(loc, len);
    NSArray<NSString *> *newZoneLogArr = [zoneLogArr subarrayWithRange:newZoneLogRange];
    
    // Save prevZoneLogArr...
    self.prevZoneLogArr = zoneLogArr;

    return newZoneLogArr;
}

- (NSArray<NSString *> *)newLogArrayOfLoadingScreenAndSavePrev {
    NSArray<NSString *> * loadingScreenLogArr = [self logArrayOf:@"LoadingScreen"];
    NSUInteger loc = self.prevLoadingScreenLogArr.count;
    NSUInteger len = loadingScreenLogArr.count - loc;
    
    if (len <= 0) return @[];
    
    NSRange newLoadingScreenLogRange = NSMakeRange(loc, len);
    NSArray<NSString *> *newLoadingScreenLogArr = [loadingScreenLogArr subarrayWithRange:newLoadingScreenLogRange];
    
    // Save prevLoadingScreenLogArr...
    self.prevLoadingScreenLogArr = loadingScreenLogArr;

    return newLoadingScreenLogArr;
}

@end