//
//  OverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 4/26/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "Game.h"

@class MainViewController;

@interface BaseOverlayView : UIView
{
    id delegate;
    Player *player;
    Game *game;
    NSMutableDictionary *infoDict;
    MainViewController *controller;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *descriptionLabel;
    NSDictionary *extraInfo;
}

@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) Player *player;
@property (nonatomic, weak) Game *game;
@property (nonatomic, weak) MainViewController *controller;
@property (nonatomic, copy) NSDictionary *infoDict;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;

@end
