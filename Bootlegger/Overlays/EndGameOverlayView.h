//
//  EndGameOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 5/26/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"

@protocol DoctorOverlayViewDelegate <NSObject>
- (void)endGameOverlayDidClickStartNewGame;
@end

@interface EndGameOverlayView : BaseOverlayView
{
    IBOutlet UILabel *endCashLabel;
    IBOutlet UILabel *endDebtLabel;
    IBOutlet UILabel *difficultyBonusLabel;
    IBOutlet UILabel *finalScoreLabel;
    int cash;
    int debt;
    int bonus;
    int final;
}

@property (nonatomic, retain) UILabel *endCashLabel;
@property (nonatomic, retain) UILabel *endDebtLabel;
@property (nonatomic, retain) UILabel *difficultyBonusLabel;
@property (nonatomic, retain) UILabel *finalScoreLabel;
@property int cash;
@property int debt;
@property int bonus;
@property int final;

- (IBAction)startNewGameClick:(id)sender;
- (void)calculateScores;

@end
