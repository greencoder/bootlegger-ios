//
//  MessageView.m
//  RumRunner
//
//  Created by Scott Newman on 4/24/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "MessageView.h"
#import "Constants.h"
#import "Player.h"
#import "Game.h"

@implementation MessageView

@synthesize messageLabel = _messageLabel;
@synthesize messages = _messages;
@synthesize player = _player;
@synthesize game = _game;

- (void)updateLabels
{
    if (self.game.daysLeft == self.game.gameLength) {
        self.messageLabel.text = [NSString stringWithFormat:@"Welcome to New York. You have %d days to make it big.",
                             self.game.gameLength];
    }
    else {
        self.messageLabel.text = [self.messages objectAtIndex:(arc4random() % [self.messages count])];
    }
}

- (void)drawRect:(CGRect)rect
{
    self.messages = @[
      @"Buy low, sell high. It doesn't take a genius to figure this game out.",
      @"Buy bigger guns to reduce the damage you take during police raids.",
      @"Visit the doctor to heal any damage inflicted during police raids.",
      @"Buying bigger vehicles at the garage will increase your inventory space.",
      @"Gambling is available in all locations. There are suckers everywhere.",
      @"Dropping items loses your investment but frees up inventory space.",
      @"Harder games have less items available on each turn.",
      @"You will drop items when fleeing from a police raid.",
      @"The harder the game, the more damage you might take during police raids.",
      @"Store your money in the bank in case you get mugged.",
      @"Interest on loans compounds daily. Pay back the loan shark quickly.",
      @"If you have a shotgun, you won't get mugged.",
      @"Muggers are everywhere in New York. Buy guns to protect yourself.",
    ];
    
    self.backgroundColor = GRAY_COLOR;
    self.messageLabel.font = FONT_14;
    self.messageLabel.textColor = DARK_GRAY_COLOR;
}

@end
