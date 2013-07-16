//
//  MapView.m
//  RumRunner
//
//  Created by Scott Newman on 4/24/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MapView.h"
#import "MainViewController.h"
#import "RetroButton.h"
#import "Constants.h"

@implementation MapView

@synthesize delegate = _delegate;
@synthesize player = _player;
@synthesize imageView = _imageView;
@synthesize selectedLocation = _selectedLocation;

- (void)updateImageForLocation:(NSString *)location
{
    NSString *imageName = [NSString stringWithFormat:@"map_%@.png",
                            [location lowercaseString]];
    imageName = [imageName stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    self.imageView.image = [UIImage imageNamed:imageName];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPosition = [touch locationInView:touch.view];
    //NSLog(@"%f, %f", touchPosition.x, touchPosition.y);

    // We have to know where they are so they can't try to travel there
    NSString *currentLocation = self.player.location;
    
    bool touchedLocation = NO;
    NSString *locationTouch;
    
    if (CGPathContainsPoint(statenPath, nil, touchPosition, NO)) {        
        if (![currentLocation isEqualToString:@"Staten Island"]) {
            locationTouch = @"Staten Island";
            touchedLocation = YES;
        }
    }
    else if (CGPathContainsPoint(bronxPath, nil, touchPosition, NO)) {
        if (![currentLocation isEqualToString:@"The Bronx"]) {
            locationTouch = @"The Bronx";
            touchedLocation = YES;
        }
    }
    else if (CGPathContainsPoint(queensPath, nil, touchPosition, NO)) {
        if (![currentLocation isEqualToString:@"Queens"]) {
            locationTouch = @"Queens";
            touchedLocation = YES;
        }
    }
    else if (CGPathContainsPoint(brooklynPath, nil, touchPosition, NO)) {
        if (![currentLocation isEqualToString:@"Brooklyn"]) {
            locationTouch = @"Brooklyn";
            touchedLocation = YES;
        }
    }
    else if (CGPathContainsPoint(manhattanPath, nil, touchPosition, NO)) {
        if (![currentLocation isEqualToString:@"Manhattan"]) {
            locationTouch = @"Manhattan";
            touchedLocation = YES;
        }
    }

    if (touchedLocation)
    {
        [self.delegate didTapMapLocation:locationTouch];
    }

}

- (void)drawRect:(CGRect)rect
{
    self.layer.backgroundColor = DARK_GRAY_COLOR.CGColor;
    self.layer.borderColor = DARK_GRAY_COLOR.CGColor;
    self.layer.borderWidth = 3.0;

    manhattan.font = FONT_14;
    statenIsland.font = FONT_14;
    bronx.font = FONT_14;
    queens.font = FONT_14;
    brooklyn.font = FONT_14;
    helpLabel.font = FONT_10;
    helpLabel.textColor = DARK_GRAY_COLOR;

    statenPath = CGPathCreateMutable();
    CGPathMoveToPoint(statenPath, nil, 5.0, 430.0);
    CGPathAddLineToPoint(statenPath, nil, 12.0, 391.0);
    CGPathAddLineToPoint(statenPath, nil, 37.0, 382.0);
    CGPathAddLineToPoint(statenPath, nil, 56.0, 303.0);
    CGPathAddLineToPoint(statenPath, nil, 155.0, 297.0);
    CGPathAddLineToPoint(statenPath, nil, 178.0, 343.0);
    CGPathAddLineToPoint(statenPath, nil, 108.0, 417.0);
    CGPathAddLineToPoint(statenPath, nil, 19.0, 452.0);
    CGPathAddLineToPoint(statenPath, nil, 3.0, 454.0);
    
    brooklynPath = CGPathCreateMutable();
    CGPathMoveToPoint(brooklynPath, nil, 262.0, 202.0);
    CGPathAddLineToPoint(brooklynPath, nil, 277.0, 207.0);
    CGPathAddLineToPoint(brooklynPath, nil, 280.0, 223.0);
    CGPathAddLineToPoint(brooklynPath, nil, 308.0, 257.0);
    CGPathAddLineToPoint(brooklynPath, nil, 332.0, 249.0);
    CGPathAddLineToPoint(brooklynPath, nil, 343.0, 268.0);
    CGPathAddLineToPoint(brooklynPath, nil, 337.0, 277.0);
    CGPathAddLineToPoint(brooklynPath, nil, 345.0, 292.0);
    CGPathAddLineToPoint(brooklynPath, nil, 319.0, 314.0);
    CGPathAddLineToPoint(brooklynPath, nil, 341.0, 356.0);
    CGPathAddLineToPoint(brooklynPath, nil, 315.0, 362.0);
    CGPathAddLineToPoint(brooklynPath, nil, 310.0, 352.0);
    CGPathAddLineToPoint(brooklynPath, nil, 219.0, 375.0);
    CGPathAddLineToPoint(brooklynPath, nil, 210.0, 364.0);
    CGPathAddLineToPoint(brooklynPath, nil, 221.0, 358.0);
    CGPathAddLineToPoint(brooklynPath, nil, 217.0, 343.0);
    CGPathAddLineToPoint(brooklynPath, nil, 191.0, 335.0);
    CGPathAddLineToPoint(brooklynPath, nil, 179.0, 307.0);
    CGPathAddLineToPoint(brooklynPath, nil, 212.0, 269.0);
    CGPathAddLineToPoint(brooklynPath, nil, 201.0, 258.0);
    CGPathAddLineToPoint(brooklynPath, nil, 222.0, 239.0);
    CGPathAddLineToPoint(brooklynPath, nil, 256.0, 220.0);
    CGPathCloseSubpath(brooklynPath);

    manhattanPath = CGPathCreateMutable();
    CGPathMoveToPoint(manhattanPath, nil, 205.0, 230.0);
    CGPathAddLineToPoint(manhattanPath, nil, 212.0, 179.0);
    CGPathAddLineToPoint(manhattanPath, nil, 281.0, 48.0);
    CGPathAddLineToPoint(manhattanPath, nil, 302.0, 43.0);
    CGPathAddLineToPoint(manhattanPath, nil, 303.0, 55.0);
    CGPathAddLineToPoint(manhattanPath, nil, 282.0, 85.0);
    CGPathAddLineToPoint(manhattanPath, nil, 283.0, 117.0);
    CGPathAddLineToPoint(manhattanPath, nil, 300.0, 137.0);
    CGPathAddLineToPoint(manhattanPath, nil, 250.0, 187.0);
    CGPathAddLineToPoint(manhattanPath, nil, 249.0, 215.0);
    CGPathAddLineToPoint(manhattanPath, nil, 210.0, 235.0);
    CGPathCloseSubpath(manhattanPath);

    bronxPath = CGPathCreateMutable();
    CGPathMoveToPoint(bronxPath, nil, 292.0, 34.0);
    CGPathAddLineToPoint(bronxPath, nil, 301.0, 5.0);
    CGPathAddLineToPoint(bronxPath, nil, 412.0, 39.0);
    CGPathAddLineToPoint(bronxPath, nil, 402.0, 74.0);
    CGPathAddLineToPoint(bronxPath, nil, 405.0, 118.0);
    CGPathAddLineToPoint(bronxPath, nil, 301.0, 124.0);
    CGPathAddLineToPoint(bronxPath, nil, 290.0, 116.0);
    CGPathAddLineToPoint(bronxPath, nil, 290.0, 87.0);
    CGPathAddLineToPoint(bronxPath, nil, 311.0, 50.0);
    CGPathAddLineToPoint(bronxPath, nil, 314.0, 36.0);
    CGPathCloseSubpath(bronxPath);

    queensPath = CGPathCreateMutable();
    CGPathMoveToPoint(queensPath, nil, 259.0, 185.0);
    CGPathAddLineToPoint(queensPath, nil, 307.0, 140.0);
    CGPathAddLineToPoint(queensPath, nil, 418.0, 131.0);
    CGPathAddLineToPoint(queensPath, nil, 491.0, 175.0);
    CGPathAddLineToPoint(queensPath, nil, 490.0, 197.0);
    CGPathAddLineToPoint(queensPath, nil, 467.0, 207.0);
    CGPathAddLineToPoint(queensPath, nil, 472.0, 282.0);
    CGPathAddLineToPoint(queensPath, nil, 432.0, 310.0);
    CGPathAddLineToPoint(queensPath, nil, 357.0, 289.0);
    CGPathAddLineToPoint(queensPath, nil, 344.0, 279.0);
    CGPathAddLineToPoint(queensPath, nil, 351.0, 268.0);
    CGPathAddLineToPoint(queensPath, nil, 336.0, 241.0);
    CGPathAddLineToPoint(queensPath, nil, 312.0, 250.0);
    CGPathAddLineToPoint(queensPath, nil, 290.0, 224.0);
    CGPathAddLineToPoint(queensPath, nil, 285.0, 205.0);
    CGPathAddLineToPoint(queensPath, nil, 258.0, 192.0);
    CGPathCloseSubpath(queensPath);
    
    // Fill in the paths for debugging:
    /*
    imageView.alpha = 0.5f;
    imageView.opaque = NO;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, statenPath);
    CGContextAddPath(context, brooklynPath);
    CGContextAddPath(context, manhattanPath);
    CGContextAddPath(context, bronxPath);
    CGContextAddPath(context, queensPath);
    CGContextFillPath(context);
    */

}

@end
