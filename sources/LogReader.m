#import "LogReader.h"

@interface LogReader ()
@property (weak) NSTimer *readTimer;
@property NSArray<NSString *> *prevZoneLogArr;
@end

@implementation LogReader

+ (instancetype)sharedInstance {
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

- (void)sendLogEvent {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSArray<NSString *> * newLogArrayOfZone = [self newLogArrayOfZone];
        if (newLogArrayOfZone.count > 0) {
            [NSNotificationCenter.defaultCenter postNotificationName:kLogReaderZoneNotificationName
                                                   object:self
                                                 userInfo:@{@"log": newLogArrayOfZone}];
        }
    });
}

- (NSArray<NSString *> *)logArrayOf:(NSString *)name {
    NSURL *documentUrl = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSURL *logsUrl = [documentUrl URLByAppendingPathComponent:@"Logs"];
    NSURL *logUrl = [[logsUrl URLByAppendingPathComponent:name] URLByAppendingPathExtension:@"log"];
    NSData *logData = [NSData dataWithContentsOfURL:logUrl];
    NSString *logStr = [[NSString alloc] initWithData:logData encoding:NSUTF8StringEncoding];
    NSArray<NSString *> *logArr = [logStr componentsSeparatedByString:@"\n"];
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *str,
                                                                   NSDictionary<NSString *,id> * _Nullable bindings) {
        // return ![str isEqualToString:@""];
        return [str containsString:@"FRIENDLY DECK"];
    }];
    NSArray *filteredLogArr = [logArr filteredArrayUsingPredicate:predicate];
    
    if (filteredLogArr == nil) return @[];
    
    return filteredLogArr;
}

- (NSArray<NSString *> *)newLogArrayOfZone {
    NSArray<NSString *> * zoneLogArr = [self logArrayOf:@"Zone"];
    NSUInteger loc = self.prevZoneLogArr.count;
    NSUInteger len = zoneLogArr.count - loc;
    
    if (len <= 0) return @[];
    
    NSRange newZoneLogRange = NSMakeRange(loc, len);
    NSArray<NSString *> *newZoneLogArr = [zoneLogArr subarrayWithRange:newZoneLogRange];
    
    self.prevZoneLogArr = zoneLogArr;
    return newZoneLogArr;
}

@end