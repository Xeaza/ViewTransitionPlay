//
//  TLTransitionAnimator.h
//  UIViewController-Transitions-Example
//
//  Created by Ash Furrow on 2013-07-18.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AwesomeTableViewCell.h"

@interface TLTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter = isPresenting) BOOL presenting;
@property (nonatomic, assign) CGRect startingPosition;
@property (nonatomic, assign) AwesomeTableViewCell *selectedCell;
@end
