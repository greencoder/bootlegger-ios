//
//  FooterView.h
//  RumRunner
//
//  Created by Scott Newman on 4/24/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Player;

@interface FooterView : UIView
{
    Player *player;
    IBOutlet UILabel *cashLabel;
    IBOutlet UILabel *cash;
    IBOutlet UILabel *debtLabel;
    IBOutlet UILabel *debt;
    IBOutlet UILabel *savingsLabel;
    IBOutlet UILabel *savings;
    IBOutlet UILabel *health;
    IBOutlet UILabel *inventoryLabel;
    IBOutlet UILabel *inventory;
    IBOutlet UIImageView *heart;
}

@property (nonatomic, weak) Player *player;

- (void)updateLabels;

@end
