//
//  GambleOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 5/21/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"
#import "WhiteRetroButton.h"

@protocol GambleOverlayViewDelegate <NSObject>
- (void)shouldCompleteWager:(int)amount;
- (void)gambleOverlayDidClickDone;
- (void)gambleOverlayDidClickCancel;
@end

@interface GambleOverlayView : BaseOverlayView
{
    UIView *highlightView;
    UIView *preventTapView;
    IBOutlet WhiteRetroButton *doneButton;
    IBOutlet WhiteRetroButton *cancelButton;
    IBOutlet UILabel *resultsLabel;
    IBOutlet WhiteRetroButton *button1;
    IBOutlet WhiteRetroButton *button2;
    IBOutlet WhiteRetroButton *button3;
    IBOutlet WhiteRetroButton *button4;
    IBOutlet WhiteRetroButton *button5;
    IBOutlet WhiteRetroButton *button6;
    IBOutlet WhiteRetroButton *button7;
    IBOutlet WhiteRetroButton *button8;
    IBOutlet WhiteRetroButton *button9;
    IBOutlet WhiteRetroButton *button10;
    IBOutlet WhiteRetroButton *wagerButton;
    NSArray *buttonArray;
    int chosenNumber;
    int winningNumber;
}

@property (nonatomic, retain) UIView *highlightView;
@property (nonatomic, retain) UIView *preventTapView;
@property (nonatomic, retain) NSArray *buttonArray;
@property (nonatomic, retain) UILabel *resultsLabel;
@property (nonatomic, retain) WhiteRetroButton *doneButton;
@property (nonatomic, retain) WhiteRetroButton *cancelButton;
@property (nonatomic, retain) WhiteRetroButton *button1;
@property (nonatomic, retain) WhiteRetroButton *button2;
@property (nonatomic, retain) WhiteRetroButton *button3;
@property (nonatomic, retain) WhiteRetroButton *button4;
@property (nonatomic, retain) WhiteRetroButton *button5;
@property (nonatomic, retain) WhiteRetroButton *button6;
@property (nonatomic, retain) WhiteRetroButton *button7;
@property (nonatomic, retain) WhiteRetroButton *button8;
@property (nonatomic, retain) WhiteRetroButton *button9;
@property (nonatomic, retain) WhiteRetroButton *button10;
@property (nonatomic, retain) WhiteRetroButton *wagerButton;
@property int chosenNumber;
@property int winningNumber;

- (int)randomIntFromRangeMin:(int)min max:(int)max;
- (void)finishWager;

@end
