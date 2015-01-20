#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;
@synthesize rank = _rank;

//note score is double counted
+ (int)match:(NSArray *)cards {
    int score = 0;
    for (PlayingCard *cardA in cards) {
        for (PlayingCard *cardB in cards) {
            if ([cardA isEqual:cardB]) {
                continue;
            }
            if (cardA.rank == cardB.rank){
                score += 2;
            }
            if ([cardA.suit isEqualToString:cardB.suit]) {
                score += 1;
            }
        }
    }
    return score;
}

- (NSString *) contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


+ (NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *) suit {
    return _suit ? _suit: @"?";
}

+ (NSArray *) rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
	return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end