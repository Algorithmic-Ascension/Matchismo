#import <Foundation/Foundation.h>

@interface GameTurn : NSObject

@property (nonatomic) BOOL didMatch;
@property (nonatomic, copy) NSString *resultDescription;
@property (nonatomic) NSInteger matchScore;

@end
