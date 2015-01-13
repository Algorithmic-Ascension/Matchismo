//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Benjamin Chen on 1/12/15.
//  Copyright (c) 2015 Benjamin Chen. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardViewController

- (Deck *)createDeck
{
	return [[PlayingCardDeck alloc] init];
}

@end
