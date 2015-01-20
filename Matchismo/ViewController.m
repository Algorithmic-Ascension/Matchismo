#import "ViewController.h"
#import "CardMatchingGame.h"
#import "GameTurn.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (strong, nonatomic)CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIButton *resetButton;
@property (strong, nonatomic) IBOutlet UILabel *announcementBox;
@property (strong, nonatomic) IBOutlet UISwitch *set2or3; //off: 2, on:3

@end

@implementation ViewController

- (CardMatchingGame *) game {
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
	GameTurn *lastTurn = self.game.history.lastObject;
	NSString *match = [NSString stringWithFormat:@"Matched %@ for %li points.", lastTurn.resultDescription, (long)lastTurn.matchScore] ;
	NSString *mismatch = [NSString stringWithFormat:@"%@ don't match! %li point penalty!", lastTurn.resultDescription, (long)lastTurn.matchScore];
	[self announcementBox:(lastTurn.didMatch ? match : mismatch)];
}

- (IBAction)resetLabelButton:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    [self updateUI];
}

- (void) announcementBox:(NSString *)announcement {
    _announcementBox.text = announcement;
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle: [self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage: [self backgroungImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score:%d", (int)self.game.score];
    }
}

- (NSString *) titleForCard:(Card *) card {
    BOOL isFaceup = card.isMatched || [self.game isInPotentialMatches:card];
    return isFaceup ? card.contents : @"";
}

- (UIImage *) backgroungImageForCard:(Card *) card {
    BOOL isFaceup = card.isMatched || [self.game isInPotentialMatches:card];
    return [UIImage imageNamed: isFaceup ? @"cardfront":@"cardback"];
}

@end
