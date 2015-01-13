#import "CardMAtchingGame.h"
#import "GameTurn.h"
#import "CardSet.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation CardMatchingGame

- (BOOL) isInPotentialMatches:(Card *)card
{
	return [self.potentialMatches.currentlyChosenCards containsObject:card];
}

- (NSInteger)match
{
#warning THIS IS FOR TESTING -- DO NOT COMMIT
	if (self.potentialMatches.currentlyChosenCards.count == self.potentialMatches.maximumSelectableCards) {
		for (Card *c in self.potentialMatches.currentlyChosenCards) {
			c.matched = YES;
		}
		[self.potentialMatches.currentlyChosenCards removeAllObjects];
		return 1;
	}
#pragma mark - end of warning

	if (self.potentialMatches.currentlyChosenCards.count < self.potentialMatches.maximumSelectableCards) {
		return 0;
	} else {
		NSInteger score = 0;
		for (Card *cardA in self.potentialMatches.currentlyChosenCards)
		{
			for (Card *cardB in self.potentialMatches.currentlyChosenCards)
			{
				if ([cardA isEqual:cardB]) {
					continue;
				}
				score += [cardA matchesCard:cardB];
			}
		}
		for (Card *c in self.potentialMatches.currentlyChosenCards) {
			c.matched = YES;
		}
		[self.potentialMatches.currentlyChosenCards removeAllObjects];
		return score - [self.potentialMatches.currentlyChosenCards count];
	}
}

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger) count
                         usingDeck:(Deck *)deck
{
    self = [super init];
	self.potentialMatches = [[CardSet alloc] initWithSetCount:2];
	if(self)
    {
        for (int i=0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card)
            {
                [self.cards addObject:card];
            }
            else
            {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}


- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
	
	//match and score
	
	[self.potentialMatches addCard:card];
	
	NSInteger matchScore = [self match];
	if (matchScore)
	{
		NSInteger adjustedScore = matchScore * matchScore * self.potentialMatches.maximumSelectableCards;
		self.score += adjustedScore;
		for ( Card *c in self.potentialMatches.currentlyChosenCards )
		{
			c.matched = YES;
		}
		GameTurn *turn = [GameTurn new];
		turn.didMatch = YES;
		turn.resultDescription = [self.potentialMatches print];
		turn.matchScore = adjustedScore;
		[self.history addObject:turn];
	}
	else
	{
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

- (Card *) cardAtIndex: (NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSMutableArray *)history
{
	if (!_history)
	{
		_history = [NSMutableArray array];
	}
	return _history;
}
@end
