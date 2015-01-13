#import <Foundation/Foundation.h>
#import "Deck.h"
#import "CardSet.h"

@interface CardMatchingGame : NSObject


@property (nonatomic) CardSet *potentialMatches;
@property (nonatomic, strong) NSMutableArray *history;
@property (nonatomic, readonly) NSInteger score;

- (instancetype) initWithCardCount:(NSUInteger) count
                         usingDeck:(Deck *)deck;
- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card *) cardAtIndex: (NSUInteger)index;
- (NSInteger)match;
- (BOOL) isInPotentialMatches:(Card *)card;


@end
