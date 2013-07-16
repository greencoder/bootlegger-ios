//
//  HeaderView.m
//  RumRunner
//
//  Created by Scott Newman on 4/24/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "HeaderView.h"
#import "Constants.h"
#import "Player.h"
#import "Game.h"

@implementation HeaderView

@synthesize player = _player;
@synthesize game = _game;

- (void)updateLabels
{
    currentLocation.text = self.player.location;
    day.text = [NSString stringWithFormat:@"%d", self.game.daysLeft];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    locationLabel.font = FONT_18;
    locationLabel.textColor = [UIColor whiteColor];
    [locationLabel sizeToFit];
    
    currentLocation.font = FONT_18;
    currentLocation.textColor = YELLOW_COLOR;
    [currentLocation sizeToFit];

    // Move location next to its label after the font is rendered
    CGRect locFrame = currentLocation.frame;
    float new_loc_x = locationLabel.frame.size.width + locationLabel.frame.origin.x + MARGIN;
    locFrame.origin.x = new_loc_x;
    currentLocation.frame = locFrame;
    
    dayLabel.font = FONT_18;
    dayLabel.textColor = [UIColor whiteColor];
    [dayLabel sizeToFit];
    
    day.font = FONT_18;
    day.textColor = YELLOW_COLOR;
    [day sizeToFit];
    
    // Move location next to its label after the font is rendered
    CGRect dayFrame = day.frame;
    float new_day_x = dayLabel.frame.size.width + dayLabel.frame.origin.x + MARGIN;
    dayFrame.origin.x = new_day_x;
    day.frame = dayFrame;
    
}

@end
