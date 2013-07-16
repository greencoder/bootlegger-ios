//
//  PauseOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 5/10/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"

@protocol PauseOverlayViewDelegate <NSObject>
- (void)pauseOverlayDidClickResume;
- (void)pauseOverlayDidClickNewGame;
@end

@interface PauseOverlayView : BaseOverlayView

@property (nonatomic, weak) id<PauseOverlayViewDelegate> delegate;

- (IBAction)resumeClick:(id)sender;
- (IBAction)newGameClick:(id)sender;

@end
