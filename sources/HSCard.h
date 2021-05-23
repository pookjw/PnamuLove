#import <Foundation/Foundation.h>

@interface HSCard : NSObject
@property (readonly) NSString *cardId;
@property (readonly) NSString *dbfId;
@property (readonly) NSString *name;
@property (readonly) NSInteger cost;
- (instancetype)initWithCardId:(NSString *)cardId
                         dbfId:(NSString *)dbfId
                          name:(NSString *)name
                          cost:(NSUInteger)cost;
@end