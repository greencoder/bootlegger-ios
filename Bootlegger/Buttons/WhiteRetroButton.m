//
//  WhiteRetroButton.m
//  RumRunner
//
//  Created by Scott Newman on 5/1/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "WhiteRetroButton.h"
#import "Constants.h"

@implementation WhiteRetroButton

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (enabled) {
        [self setAlpha:1.0f];
        self.titleLabel.textColor = VERY_DARK_GRAY_COLOR;
    }
    else {
        [self setAlpha:0.5f];
        self.titleLabel.textColor = VERY_DARK_GRAY_COLOR;
    }
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderWidth = 3.0;
    self.layer.borderColor = [borderColor CGColor];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.layer.backgroundColor = LIGHT_BLUE_COLOR.CGColor;
        self.titleLabel.textColor = VERY_DARK_GRAY_COLOR;
    }
    else {
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.titleLabel.textColor = VERY_DARK_GRAY_COLOR;
    }
}

- (void)showAsSelected:(BOOL)isSelected
{
    if (isSelected)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.highlighted = YES;
        }];
    }
    else
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.highlighted = NO;
        }];
    }
}

- (void)drawRect:(CGRect)rect
{
    self.titleLabel.font = FONT_15;
    self.titleLabel.textColor = VERY_DARK_GRAY_COLOR;
    [self.titleLabel sizeToFit];

    [self setTitleColor:VERY_DARK_GRAY_COLOR forState:UIControlStateNormal];
    [self setTitleColor:VERY_DARK_GRAY_COLOR forState:UIControlStateHighlighted];
    [self setTitleColor:VERY_DARK_GRAY_COLOR forState:UIControlStateSelected];
    
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.borderColor = VERY_DARK_GRAY_COLOR.CGColor;
    self.layer.borderWidth = 3.0;
}

@end
