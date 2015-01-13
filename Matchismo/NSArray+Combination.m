//
//  NSArray+Combination.m
//  Matchismo
//
//  Created by Benjamin Chen on 1/9/15.
//  Copyright (c) 2015 Benjamin Chen. All rights reserved.
//

#import "NSArray+Combination.h"

@implementation NSArray (Combination)

- (NSArray *)combinations
{
	NSMutableArray *combinations = [[NSMutableArray alloc] init];
	
	for (NSInteger i = 0; i < [self count]; i++) {
		for(NSInteger j = i+1; j < [self count]; j++){
			NSArray *newCombination = @[[self objectAtIndex:i],
									   [self objectAtIndex:j]];
			[combinations addObject:newCombination];
		}
	}
	return combinations;
}

@end
