//
//  FinishGameView.m
//  RumRunner
//
//  Created by Scott Newman on 5/27/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "FinishGameView.h"
#import "Constants.h"
#import <QuartzCore/QuartzCore.h>

@implementation FinishGameView

@synthesize descriptionLabel = _descriptionLabel;

- (IBAction)finishClick:(id)sender
{
    [self.delegate finishGameViewDidClickFinish];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    self.layer.borderColor = DARK_GRAY_COLOR.CGColor;
    self.layer.borderWidth = 3.0;

    self.descriptionLabel.font = FONT_16;
    self.descriptionLabel.textColor = DARK_GRAY_COLOR;
}

@end
