//
//  MarketView.m
//  RumRunner
//
//  Created by Scott Newman on 4/24/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MarketView.h"
#import "Constants.h"

@implementation MarketView

@synthesize delegate = _delegate;
@synthesize tableView = _tableView;

- (void)drawRect:(CGRect)rect
{
    self.layer.backgroundColor = GRAY_COLOR.CGColor;
    self.layer.borderColor = DARK_GRAY_COLOR.CGColor;
    self.layer.borderWidth = 3.0;

    priceLabel.font = FONT_14;
    priceLabel.textColor = PINK_COLOR;
    itemLabel.font = FONT_14;
    itemLabel.textColor = PINK_COLOR;
    qtyLabel.font = FONT_14;
    qtyLabel.textColor = PINK_COLOR;
    ownedLabel.font = FONT_14;
    ownedLabel.textColor = PINK_COLOR;
    helpLabel.font = FONT_10;
    helpLabel.textColor = DARK_GRAY_COLOR;
    
    // Draw a gray line above table view
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.0f);
    CGContextSetRGBStrokeColor(ctx, 0.97, 0.97, 0.97, 1);
    CGContextMoveToPoint(ctx, 0.0f, 50.0f);
    CGContextAddLineToPoint(ctx, 434.0f, 50.0f);
    CGContextStrokePath(ctx);
}


@end
