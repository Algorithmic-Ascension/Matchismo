#import <Foundation/Foundation.h>
#import "Card.h"

@interface CardSet : NSObject

@property (strong, nonatomic) NSMutableArray *currentlyChosenCards;
@property (nonatomic) NSInteger maximumSelectableCards;

- (instancetype)initWithMaximumSelectableCards:(NSInteger)i;
- (void) addCard:(Card *)card removing:(Card *)removing;
- (void) addCard:(Card *)card;
- (NSString *) print;

@end















