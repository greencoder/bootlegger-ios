//
//  NewGameOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 5/10/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"
#import "WhiteRetroButton.h"

@protocol NewGameOverlayViewDelegate <NSObject>
- (void)shouldStartNewGameWithLength:(int)length difficulty:(int)difficulty;
- (void)newGameOverlayDidClickOkay;
- (void)shouldResetGame;
@end

@interface NewGameOverlayView : BaseOverlayView
{
    IBOutlet UILabel *difficultyLabel;
    IBOutlet UILabel *lengthLabel;
    IBOutlet WhiteRetroButton *okayButton;
    IBOutlet WhiteRetroButton *easyButton;
    IBOutlet WhiteRetroButton *mediumButton;
    IBOutlet WhiteRetroButton *hardButton;
    IBOutlet WhiteRetroButton *days30Button;
    IBOutlet WhiteRetroButton *days45Button;
    IBOutlet WhiteRetroButton *days60Button;
    int chosenDifficulty;
    int chosenLength;
}

@property (nonatomic, weak) id<NewGameOverlayViewDelegate> delegate;
@property (nonatomic, retain) UILabel *difficultyLabel;
@property (nonatomic, retain) UILabel *lengthLabel;
@property (nonatomic, retain) WhiteRetroButton *okayButton;
@property (nonatomic, retain) WhiteRetroButton *easyButton;
@property (nonatomic, retain) WhiteRetroButton *mediumButton;
@property (nonatomic, retain) WhiteRetroButton *hardButton;
@property (nonatomic, retain) WhiteRetroButton *days30Button;
@property (nonatomic, retain) WhiteRetroButton *days45Button;
@property (nonatomic, retain) WhiteRetroButton *days60Button;
@property int chosenDifficulty;
@property int chosenLength;

- (IBAction)difficultyButtonClick:(id)sender;
- (IBAction)lengthButtonClick:(id)sender;
- (void)updateLabels;

@end
