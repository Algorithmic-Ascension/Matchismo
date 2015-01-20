#import "CardMatchingGame.h"
#import "GameTurn.h"
#import "CardSet.h"
#import "PlayingCard.h"
#include "config.h"


@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

@end

@implementation CardMatchingGame

- (BOOL) isInPotentialMatches:(Card *)card {
	return [self.potentialMatches.currentlyChosenCards containsObject:card];
}

- (NSInteger)match {

	if (self.potentialMatches.currentlyChosenCards.count < self.potentialMatches.maximumSelectableCards) {
		return 0;
	} else {
		NSInteger score = [PlayingCard match:self.potentialMatches.currentlyChosenCards];
		if (score > 0) {
			for (Card *c in self.potentialMatches.currentlyChosenCards) {
				c.matched = YES;
			}
			[self.potentialMatches.currentlyChosenCards removeAllObjects];
		}
		return score;
	}
}

- (NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


#warning TODO: put in config file, list of constants, leaving out static keyword did not work, try #define maybe?
static const int MAXIMUM_SELECTABLE_CARDS = 3;
- (instancetype) initWithCardCount:(NSUInteger) count
                         usingDeck:(Deck *)deck {
    self = [super init];
	self.potentialMatches = [[CardSet alloc] initWithMaximumSelectableCards:MAXIMUM_SELECTABLE_CARDS];
	if(self) {
        for (int i=0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}


- (void) chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
	
	//match and score
	
	[self.potentialMatches addCard:card];
	
	NSInteger matchScore = [self match];
	if (matchScore) {
		NSInteger adjustedScore = matchScore * matchScore * self.potentialMatches.maximumSelectableCards;
		self.score += adjustedScore;
		for ( Card *c in self.potentialMatches.currentlyChosenCards ) {
			c.matched = YES;
		}
		GameTurn *turn = [GameTurn new];
		turn.didMatch = YES;
		turn.resultDescription = [self.potentialMatches print];
		turn.matchScore = adjustedScore;
		[self.history addObject:turn];
	} else {
		self.score -= self.potentialMatches.maximumSelectableCards-1;
		card.matched = NO;
		
		GameTurn *turn = [GameTurn new];
		turn.didMatch = NO;
		turn.resultDescription = [self.potentialMatches print];
		turn.matchScore = self.potentialMatches.maximumSelectableCards-1;
		[self.history addObject:turn];
	}
	self.score -= self.potentialMatches.maximumSelectableCards-1;
}

- (Card *) cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSMutableArray *)history {
	if (!_history) {
		_history = [NSMutableArray array];
	}
	return _history;
}

@end
