//
//  TravelOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 4/26/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseOverlayView.h"

@protocol TravelOverlayViewDelegate <NSObject>
- (void)shouldTravelToLocation:(NSString *)newLocation;
- (void)travelOverlayDidClickOkay;
- (void)travelOverlayDidClickCancel;
@end

@interface TravelOverlayView : BaseOverlayView

@property (nonatomic, weak) id<TravelOverlayViewDelegate> delegate;

- (IBAction)okayClick:(id)sender;
- (IBAction)cancelClick:(id)sender;

@end
