#import <hearthstone/UnityAppController.h>
#import "LogParser.h"

%hook UnityAppController

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    [self performSelector:@selector(configureLogConfig)];
    [self performSelector:@selector(removeOldLogs)];
    [self performSelector:@selector(startLogParser)];
    [self performSelector:@selector(reisterTestObservers)];
    return %orig(application, launchOptions);
}

%new
- (void)configureLogConfig {
    NSString *configStr = @"[LoadingScreen]\n\
LogLevel=1\n\
FilePrinting=true\n\
ConsolePrinting=true\n\
ScreenPrinting=false\n\
\n\
[Zone]\n\
LogLevel=1\n\
FilePrinting=true\n\
ConsolePrinting=true\n\
ScreenPrinting=false\n\
";

    NSData *configData = [configStr dataUsingEncoding:NSUTF8StringEncoding];
    NSURL *documentURL = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSURL *configURL = [[documentURL URLByAppendingPathComponent:@"log"] URLByAppendingPathExtension:@"config"];
    [configData writeToURL:configURL options:NSDataWritingAtomic error:nil];
}

%new
- (void)removeOldLogs {
    [NSFileManager.defaultManager removeItemAtURL:LogReader.sharedInstance.logsURL error:nil];
}

%new
- (void)startLogParser {
    [LogParser.sharedInstance startObserving];
}

%new
- (void)reisterTestObservers {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(gotEvent:)
                                               name:kLogParserDidStartTheGameNotificationName
                                             object:LogParser.sharedInstance];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(gotEvent:)
                                               name:kLogParserDidEndTheGameNotificationName
                                             object:LogParser.sharedInstance];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(gotEvent:)
                                               name:kLogParserDidRemoveCardFromDeckNotificationName
                                             object:LogParser.sharedInstance];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(gotEvent:)
                                               name:kLogParserDidAddCardToDeckNotificationName
                                             object:LogParser.sharedInstance];
}

%new
- (void)gotEvent:(NSNotification *)notification {
    NSLog(@"%@, %@", notification.name, notification.userInfo);
}

%end
