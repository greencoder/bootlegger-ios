//
//  Game.m
//  RumRunner
//
//  Created by Scott Newman on 5/6/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "Game.h"

@implementation Game

@synthesize latestMessage = _lastestMessage;
@synthesize policeDays = _policeDays;
@synthesize muggingDays = _muggingDays;
@synthesize daysLeft = _daysLeft;
@synthesize gameLength = _gameLength;
@synthesize difficulty = _difficulty;

- (id)initWithLength:(int)newLength difficulty:(int)newDifficulty
{
    self = [super init];
    if (self)
    {
        [self configureWithLength:newLength difficulty:newDifficulty];
    }
    return self;
}

- (void)configureWithLength:(int)newLength difficulty:(int)newDifficulty
{
    self.latestMessage = [NSString stringWithFormat:@"Welcome to New York. You have %d days to make it big.",
                          newLength];
    self.daysLeft = newLength;
    self.gameLength = newLength;
    self.difficulty = newDifficulty;
    
    [self generatePoliceAndMuggingDays];
}

- (void)generatePoliceAndMuggingDays
{
    NSMutableArray *days = [[NSMutableArray alloc] initWithCapacity:self.gameLength];
    
    // In a 30 day game, the police should raid you 3,5,7  times (depending on difficulty)
    // In a 45 day game, the police should raid you 5,7,9  times (depending on difficulty)
    // In a 60 day game, the police should raid you 7,9,11 times (depending on difficulty)
    
    // Muggings should be 5% of the number of days
    
    // Make an array of all the days so we can remove the day after chosing it. This
    // prevents us from selecting the same day twice. We start at 4 so no muggings or
    // raids happen in the first 4 days. (it's not fun, and players don't have much
    // cash or product yet anyway)
    for (int idx=4; idx<=self.gameLength; idx++)
    {
        [days addObject:[NSNumber numberWithInt:idx]];
    }
    
    // Based on the number of days, there will be 10%, 15%, or 20% police raid days
    int numPoliceDays = round(self.gameLength * 0.10);
    int numMuggingDays = round(self.gameLength * 0.05);
    
    // If a 60 day game, add one to make it 7,9,11
    if (self.gameLength == 60) {
        numPoliceDays += 1;
    }
    
    // If medium or hard game, add more days
    if (self.difficulty == 2) {
        numPoliceDays += 2;
        numMuggingDays += 1;
    }
    else if (self.difficulty == 3) {
        numPoliceDays += 4;
        numMuggingDays += 2;
    }
    
    // Generate the police days
    self.policeDays = [[NSMutableArray alloc] initWithCapacity:numPoliceDays];
    for (int idx=0; idx<numPoliceDays; idx++)
    {
        NSUInteger randomIndex = arc4random() % [days count];
        [self.policeDays addObject:days[randomIndex]];
        [days removeObjectAtIndex:randomIndex];
    }
    
    // Generate the mugging days
    self.muggingDays = [[NSMutableArray alloc] initWithCapacity:numMuggingDays];
    
    for (int idx=0; idx<numMuggingDays; idx++)
    {
        NSUInteger randomIndex = arc4random() % [days count];
        [self.muggingDays addObject:days[randomIndex]];
        [days removeObjectAtIndex:randomIndex];
    }

}

- (int)randomIntFromRangeMin:(int)min max:(int)max
{
    return round(((float)arc4random() / 0x100000000 * (max - min)) + min);
}

#pragma mark init with coder

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.latestMessage forKey:@"latestMessage"];
    [aCoder encodeObject:self.policeDays forKey:@"policeDays"];
    [aCoder encodeObject:self.muggingDays forKey:@"muggingDays"];
    [aCoder encodeInt:self.daysLeft forKey:@"daysLeft"];
    [aCoder encodeInt:self.gameLength forKey:@"gameLength"];
    [aCoder encodeInt:self.difficulty forKey:@"difficulty"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        [self setLatestMessage:[aDecoder decodeObjectForKey:@"latestMessage"]];
        [self setPoliceDays:[aDecoder decodeObjectForKey:@"policeDays"]];
        [self setMuggingDays:[aDecoder decodeObjectForKey:@"muggingDays"]];
        [self setDaysLeft:[aDecoder decodeIntForKey:@"daysLeft"]];
        [self setGameLength:[aDecoder decodeIntForKey:@"gameLength"]];
        [self setDifficulty:[aDecoder decodeIntForKey:@"difficulty"]];
    }
    return self;
}

@end
