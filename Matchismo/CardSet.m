#import "CardSet.h"

@implementation CardSet

- (instancetype)initWithSetCount:(NSInteger) i
{
	self.currentlyChosenCards = [[NSMutableArray alloc] init];
	self.maximumSelectableCards = i;
	return self;
}

- (void)addCard:(Card *)card
{
	[self addCard:card removing:nil];
}

- (void) addCard:(Card *)card removing:(Card *)removing
{
	if ([self.currentlyChosenCards count] >= self.maximumSelectableCards) {
		if(removing)
		{
			[self.currentlyChosenCards removeObject:removing];
		}
		else
		{
			[self.currentlyChosenCards removeLastObject];
		}
	}
	[self.currentlyChosenCards insertObject:card atIndex:0];
}

- (void) addCards:(NSArray *)cards
{
	for (Card *c in cards)
	{
		[self addCard:c];
	}
}

- (void) removeCard:(Card *)card
{
	[self.currentlyChosenCards removeObject:card];
}

//concat all contents
- (NSString *) print
{
	NSString *s = @"";
	for ( Card *c in self.currentlyChosenCards )
	{
		s = [s stringByAppendingString: c.contents];
	}
	return s;
}

@end