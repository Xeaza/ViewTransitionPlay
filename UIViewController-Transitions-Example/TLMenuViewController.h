//
//  TLMenuViewController.h
//  UIViewController-Transitions-Example
//
//  Created by Ash Furrow on 2013-07-18.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLMenuViewController;

// This protocol is only to silence the compiler since we're using one of two different classes.
@protocol TLMenuViewControllerPanTarget <NSObject>

-(void)userDidPan:(UIScreenEdgePanGestureRecognizer *)gestureRecognizer;

@end

@interface TLMenuViewController : UIViewController

-(id)initWithPanTarget:(id<TLMenuViewControllerPanTarget>)panTarget;

@property (nonatomic, readonly) id<TLMenuViewControllerPanTarget> panTarget;

@end
