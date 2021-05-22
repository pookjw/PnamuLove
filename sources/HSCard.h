#import <Foundation/Foundation.h>

@interface HSCard : NSObject
@property (readonly) NSString *cardId;
@property (readonly) NSString *dbfId;
@property (readonly) NSString *name;
@property (readonly) NSString *cost;
@end