//
//  MessageView.h
//  RumRunner
//
//  Created by Scott Newman on 4/24/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Player;
@class Game;

@interface MessageView : UIView
{
    IBOutlet UILabel *messageLabel;
    NSArray *messages;
    Player *player;
    Game *game;
}

@property (nonatomic, retain) UILabel *messageLabel;
@property (nonatomic, retain) NSArray *messages;
@property (nonatomic, weak) Player *player;
@property (nonatomic, weak) Game *game;

- (void)updateLabels;

@end
