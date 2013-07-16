//
//  PriceCell.m
//  RumRunner
//
//  Created by Scott Newman on 5/10/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "PriceCell.h"
#import "Constants.h"

@implementation PriceCell

@synthesize nameLabel = _nameLabel;
@synthesize priceRangeLabel = _priceRangeLabel;

- (void)drawRect:(CGRect)rect
{
    //self.backgroundColor = MED_GRAY_COLOR;
    self.priceRangeLabel.font = FONT_16;
    self.priceRangeLabel.textColor = VERY_DARK_GRAY_COLOR;
    self.nameLabel.font = FONT_16;
    self.nameLabel.textColor = VERY_DARK_GRAY_COLOR;
    
    // Draw a white line
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.0f);
    CGContextSetRGBStrokeColor(ctx, 0.97, 0.97, 0.97, 1);
    CGContextMoveToPoint(ctx, 0.0f, rect.size.height-1);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height-1);
    CGContextStrokePath(ctx);
}

@end
