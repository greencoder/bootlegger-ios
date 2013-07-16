//
//  CustomCell.m
//  RumRunner
//
//  Created by Scott Newman on 4/25/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "MarketCell.h"
#import "Constants.h"

@implementation MarketCell

@synthesize itemLabel = _itemLabel;
@synthesize priceLabel = _priceLabel;
@synthesize qtyLabel = _qtyLabel;
@synthesize ownedLabel = _ownedLabel;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    UIView *bgView = [[UIView alloc] initWithFrame:self.backgroundView.frame];
    bgView.backgroundColor = MED_GRAY_COLOR;
    self.selectedBackgroundView = bgView;
    
}

- (void)drawRect:(CGRect)rect
{
    
    self.itemLabel.font = FONT_14;
    self.itemLabel.textColor = DARK_GRAY_COLOR;
    self.priceLabel.font = FONT_14;
    self.priceLabel.textColor = DARK_GRAY_COLOR;
    self.qtyLabel.font = FONT_14;
    self.qtyLabel.textColor = DARK_GRAY_COLOR;
    self.ownedLabel.font = FONT_14;
    self.ownedLabel.textColor = DARK_GRAY_COLOR;
    
    // Draw a white line
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1.0f);
    CGContextSetRGBStrokeColor(ctx, 0.97, 0.97, 0.97, 1);
    CGContextMoveToPoint(ctx, 0.0f, rect.size.height-1);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height-1);
    CGContextStrokePath(ctx);
}

@end
