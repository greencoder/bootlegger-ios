//
//  StretchButton.m
//  RumRunner
//
//  Created by Scott Newman on 4/26/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RetroButton.h"
#import "Constants.h"

@implementation RetroButton

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (enabled) {
        [self setAlpha:1.0f];
        self.titleLabel.textColor = DARK_GRAY_COLOR;
    }
    else {
        [self setAlpha:0.5f];
        self.titleLabel.textColor = DARK_GRAY_COLOR;
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.titleLabel.textColor = DARK_GRAY_COLOR;
    
    if (highlighted) {
        self.layer.backgroundColor = LIGHT_BLUE_COLOR.CGColor;
        self.titleLabel.textColor = DARK_GRAY_COLOR;
    }
    else {
        self.layer.backgroundColor = GRAY_COLOR.CGColor;
        self.titleLabel.textColor = DARK_GRAY_COLOR;
    }
}

- (void)drawRect:(CGRect)rect
{
    self.titleLabel.font = FONT_15;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = DARK_GRAY_COLOR;

    [self setTitleColor:DARK_GRAY_COLOR forState:UIControlStateNormal];
    [self setTitleColor:DARK_GRAY_COLOR forState:UIControlStateHighlighted];
    [self setTitleColor:DARK_GRAY_COLOR forState:UIControlStateSelected];
    
    self.layer.backgroundColor = GRAY_COLOR.CGColor;
    self.layer.borderColor = DARK_GRAY_COLOR.CGColor;
    self.layer.borderWidth = 3.0;
}

@end
