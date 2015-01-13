#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isMatched) BOOL matched;
- (int)matchesCard:(Card *)card;
@end