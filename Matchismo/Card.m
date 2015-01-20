#import "Card.h"

@interface Card()
@end
@implementation Card

- (int)match:(NSArray *)otherCards {
	for (Card *card in otherCards ) {
		if([self.contents isEqualToString:card.contents]) {
			return 1;
		}
	}
	return 0;
}
@end
