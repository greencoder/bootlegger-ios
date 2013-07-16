//
//  FinishGameView.h
//  RumRunner
//
//  Created by Scott Newman on 5/27/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"

@protocol FinishGameViewDelegate <NSObject>
- (void)finishGameViewDidClickFinish;
@end

@interface FinishGameView : UIView
{
    IBOutlet UILabel *descriptionLabel;
}

@property (nonatomic, weak) id<FinishGameViewDelegate> delegate;
@property (nonatomic, retain) UILabel *descriptionLabel;

@end
