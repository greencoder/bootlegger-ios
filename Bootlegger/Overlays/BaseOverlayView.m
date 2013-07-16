//
//  OverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 4/26/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BaseOverlayView.h"
#import "RetroButton.h"
#import "Constants.h"

@implementation BaseOverlayView

@synthesize delegate = _delegate;
@synthesize player = _player;
@synthesize game = _game;
@synthesize controller = _controller;
@synthesize infoDict = _infoDict;
@synthesize titleLabel = _titleLabel;
@synthesize descriptionLabel = _descriptionLabel;

- (void)drawRect:(CGRect)rect
{
    //self.layer.backgroundColor = [UIColor orangeColor].CGColor;
    self.layer.borderColor = VERY_DARK_GRAY_COLOR.CGColor;
    self.layer.borderWidth = 3.0;

    self.titleLabel.font = FONT_16;
    self.titleLabel.textColor = VERY_DARK_GRAY_COLOR;
    
    self.descriptionLabel.font = FONT_16;
    self.descriptionLabel.textColor = VERY_DARK_GRAY_COLOR;
    
    // Draw a black line under header view
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 3.0f);
    CGContextSetRGBStrokeColor(ctx, 0.2, 0.2, 0.2, 1.0);
    CGContextMoveToPoint(ctx, 0.0f, 49.0);
    CGContextAddLineToPoint(ctx, rect.size.width, 49.0);
    CGContextStrokePath(ctx);
}

@end
