//
//  MapView.h
//  RumRunner
//
//  Created by Scott Newman on 4/24/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "Player.h"

@class MainViewController;

@protocol MapViewDelegate <NSObject>
- (void)didTapMapLocation:(NSString *)location;
- (void)shouldFinishGame;
@end

@interface MapView : UIView
{
    id<MapViewDelegate> delegate;
    IBOutlet UIImageView *imageView;
    IBOutlet UILabel *manhattan;
    IBOutlet UILabel *statenIsland;
    IBOutlet UILabel *bronx;
    IBOutlet UILabel *queens;
    IBOutlet UILabel *brooklyn;
    IBOutlet UILabel *helpLabel;

    CGMutablePathRef statenPath;
    CGMutablePathRef brooklynPath;
    CGMutablePathRef manhattanPath;
    CGMutablePathRef queensPath;
    CGMutablePathRef bronxPath;
}

@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) Player *player;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, weak) MainViewController *controller;
@property (nonatomic, retain) NSString *selectedLocation;

- (void)updateImageForLocation:(NSString *)location;

@end
