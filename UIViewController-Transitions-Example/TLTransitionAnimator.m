//
//  TLTransitionAnimator.m
//  UIViewController-Transitions-Example
//
//  Created by Ash Furrow on 2013-07-18.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import "TLTransitionAnimator.h"

@implementation TLTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 2.0f;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    // Grab the from and to view controllers from the context
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // This is the frame that the detailView ends up as
    CGRect endFrame = CGRectMake(0, 0, toViewController.view.layer.frame.size.width, toViewController.view.layer.frame.size.height);

    if (self.presenting) {
        fromViewController.view.userInteractionEnabled = NO;
        
        //[transitionContext.containerView addSubview:fromViewController.view];
        [transitionContext.containerView addSubview:toViewController.view];
        
        CGRect startFrame = endFrame;
        startFrame = self.startingPosition;
        // Get height of the statusBar + the navigationBar (== 44)
        startFrame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height + 44;
        // Google find nav bar height programatically
        toViewController.view.frame = startFrame;

        // Loop through selectedCell's subviews
        CGRect startingTitleLabelFrame;
        for (UIView *subView in self.selectedCell.contentView.subviews) {
            //NSLog(@"%@", [subView class]);

            if ([subView class] == [UILabel class]) {
                UILabel *label = (UILabel *)subView;
                startingTitleLabelFrame = label.frame;
                //NSLog(@"%f %f", subView.frame.origin.x, subView.frame.origin.y);
            }
        }
        CGRect detailTitleLabelFrame;
        // Loop through detailView's subviews
        for (UIView *subView in toViewController.view.subviews) {
            NSLog(@"%@", [subView class]);
            if ([subView isKindOfClass:[UILabel class]]) {
                //NSLog(@"Hi");
                UILabel *label = (UILabel *)subView;
                detailTitleLabelFrame.origin.y = 80;
//                detailTitleLabelFrame.origin.y = [UIApplication sharedApplication].statusBarFrame.size.height + 44 + 80;
                label.frame = detailTitleLabelFrame;
                //label.text = @"HI";
                NSLog(@"Detail: %f %f", detailTitleLabelFrame.origin.x, detailTitleLabelFrame.origin.y);
                NSLog(@"Starting: %f %f", startingTitleLabelFrame.origin.x, startingTitleLabelFrame.origin.y);

                //detailViewTitleLabel.frame = startingTitleLabelFrame;
               //// NSLog(@"👍");
               // NSLog(@"%@", [subView class]);
            }
        }

        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^
        {
            //toViewController.view.alpha = 1.0;
            fromViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
            toViewController.view.frame = endFrame;


        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    else {
        toViewController.view.userInteractionEnabled = YES;
        
        //[transitionContext.containerView addSubview:toViewController.view];
        //[transitionContext.containerView addSubview:fromViewController.view];
        
        endFrame = self.startingPosition;
        // Get height of the statusBar + the navigationBar
        endFrame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height + 44;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^
        {
            toViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
            fromViewController.view.frame = endFrame;
            for (UIView *subView in fromViewController.view.subviews) {
                subView.alpha = 0.0;
            }
            //toViewController.view.alpha = 1.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

//- (void) animateOnEntry
//{
//    //set initial frames
//    self.backgroundImageView.alpha = 0;
//    self.backgroundImageView.frame = CGRectMake(0, self.yOrigin + MAIN_LABEL_Y_ORIGIN, self.view.frame.size.width, self.labelForPlace.frame.size.height + self.labelForCountry.frame.size.height);
//    self.labelForPlace.frame = CGRectMake(70, self.yOrigin + MAIN_LABEL_Y_ORIGIN, self.labelForPlace.frame.size.width, self.labelForPlace.frame.size.height);
//    self.labelForCountry.frame = CGRectMake(70, self.labelForPlace.frame.origin.y + self.labelForPlace.frame.size.height, self.labelForCountry.frame.size.width, self.labelForCountry.frame.size.height);
//    self.imageView.frame = CGRectMake(10, self.yOrigin + IMAGEVIEW_Y_ORIGIN, 50, 50);
//    self.doneBtn.frame = CGRectMake(self.doneBtn.frame.origin.x, 0-self.doneBtn.frame.size.height-20, self.doneBtn.frame.size.width, self.doneBtn.frame.size.height);
//    self.textviewForDetail.alpha = 0;
//    self.textviewForDetail.frame = CGRectMake(self.textviewForDetail.frame.origin.x, self.textviewForDetail.frame.size.height + self.view.frame.size.height, self.textviewForDetail.frame.size.width, self.textviewForDetail.frame.size.height);
//
//    //apply animation on ENTERING INTO THE VIEW
//    [UIView animateWithDuration:0.4f
//                          delay:0
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^(void)
//     {
//         self.labelForPlace.frame = CGRectMake(35, 180, self.labelForPlace.frame.size.width, self.labelForPlace.frame.size.height);
//         self.labelForCountry.frame = CGRectMake(35, 250, self.labelForCountry.frame.size.width, self.labelForCountry.frame.size.height);
//         self.doneBtn.frame = CGRectMake(self.doneBtn.frame.origin.x, 20, self.doneBtn.frame.size.width, self.doneBtn.frame.size.height);
//         self.backgroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
//         self.backgroundImageView.alpha = 1;
//
//         self.textviewForDetail.frame = CGRectMake(self.textviewForDetail.frame.origin.x, self.view.frame.size.height - self.textviewForDetail.frame.size.height, self.textviewForDetail.frame.size.width, self.textviewForDetail.frame.size.height);
//         self.textviewForDetail.alpha = 1;
//
//         NSLog(@"width %f height %f",self.imageView.frame.size.width,self.imageView.frame.size.height);
//
//         self.imageView.frame = CGRectMake(110, 50, self.imageView.frame.size.width * 2, self.imageView.frame.size.height * 2);
//     }
//                     completion:NULL];
//}


@end