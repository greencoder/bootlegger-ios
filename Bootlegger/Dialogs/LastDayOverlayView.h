//
//  LastDayOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 5/25/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"

@protocol LastDayOverlayViewDelegate <NSObject>
- (void)lastDayOverlayDidClickDone;
@end

@interface LastDayOverlayView : BaseOverlayView

@end
