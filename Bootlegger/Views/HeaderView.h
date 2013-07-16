//
//  HeaderView.h
//  RumRunner
//
//  Created by Scott Newman on 4/24/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game;
@class Player;

@interface HeaderView : UIView
{
    Player *player;
    Game *game;
    IBOutlet UILabel *locationLabel;
    IBOutlet UILabel *currentLocation;
    IBOutlet UILabel *dayLabel;
    IBOutlet UILabel *day;
}

@property (nonatomic, weak) Player *player;
@property (nonatomic, weak) Game *game;

- (void)updateLabels;

@end
