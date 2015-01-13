//
//  GameTurn.h
//  Matchismo
//
//  Created by Benjamin Chen on 1/9/15.
//  Copyright (c) 2015 Benjamin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameTurn : NSObject
@property (nonatomic) BOOL didMatch;
@property (nonatomic, copy) NSString *resultDescription;
@property (nonatomic) NSInteger matchScore;
@end
