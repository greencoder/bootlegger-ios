//
//  MuggingOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 6/4/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"

@protocol MuggingOverlayViewDelegate <NSObject>
- (void)muggingOverlayDidClickOkay;
- (void)muggingOverlayDidGetMugged:(int)cashLost;
@end

@interface MuggingOverlayView : BaseOverlayView
{
    IBOutlet UILabel *cashLostLabel;
}

@property (nonatomic, weak) id<MuggingOverlayViewDelegate> delegate;
@property (nonatomic, retain) UILabel *cashLostLabel;

@end
