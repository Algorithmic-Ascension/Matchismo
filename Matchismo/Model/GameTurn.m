#import "GameTurn.h"

@implementation GameTurn

- (instancetype) initWithDidMatch:(BOOL)didMatch
				resultDescription:(NSString *)resultDescription
					   matchScore:(NSInteger)matchScore {
	GameTurn *turn = [GameTurn new];
	turn.didMatch = didMatch;
	turn.resultDescription = resultDescription;
	turn.matchScore = matchScore;
	return turn;
}

@end
