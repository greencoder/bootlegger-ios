//
//  Game.h
//  RumRunner
//
//  Created by Scott Newman on 5/6/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject <NSCoding>
{
    NSString *latestMessage;
    NSMutableArray *policeDays;
    NSMutableArray *muggingDays;
    int daysLeft;
    int gameLength;
    int difficulty;
}

@property (nonatomic, retain) NSString *latestMessage;
@property (nonatomic, retain) NSMutableArray *policeDays;
@property (nonatomic, retain) NSMutableArray *muggingDays;
@property int difficulty;
@property int daysLeft;
@property int gameLength;

- (id)initWithLength:(int)newLength difficulty:(int)newDifficulty;
- (void)configureWithLength:(int)newLength difficulty:(int)newDifficulty;
- (void)generatePoliceAndMuggingDays;
- (int)randomIntFromRangeMin:(int)min max:(int)max;

@end
