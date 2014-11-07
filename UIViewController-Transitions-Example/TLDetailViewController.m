//
//  TLDetailViewController.m
//  UIViewController-Transitions-Example
//
//  Created by Ash Furrow on 2013-07-12.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import "TLDetailViewController.h"

@interface TLDetailViewController ()

@end

@implementation TLDetailViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self animateOnEntry];
}

-(IBAction)doneWasPressed:(id)sender {
    //animation on EXIT FROM CURRENT VIEW
    [UIView animateWithDuration:1.5f animations:^
     {
         CGRect startFrame = self.startingPosition;
         startFrame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height + 44;
         self.view.frame = startFrame;

         CGRect endFrame = self.view.frame;
         NSLog(@"Ending Frame: x:%f y:%f height:%f width:%f", endFrame.origin.x, endFrame.origin.y, endFrame.size.height, endFrame.size.width);
     }
                     completion:^(BOOL finished)
     {
         //[self.navigationController popViewControllerAnimated:NO];
         [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
     }
     ];
}

- (void) animateOnEntry
{
    //set initial frames
    CGRect selectedCellsLabelPosition = CGRectMake(0, 0, self.titleLabel.frame.size.height, self.titleLabel.frame.size.height);
    CGRect endLabelFrame = self.titleLabel.frame;
    self.titleLabel.frame = selectedCellsLabelPosition;
//    for (UIView *subView in self.presentingViewController.view.subviews) {


    CGRect startFrame = self.startingPosition;
    startFrame.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height + 44;

    NSLog(@"Starting Frame: x:%f y:%f height:%f width:%f", startFrame.origin.x, startFrame.origin.y, startFrame.size.height, startFrame.size.width);
    CGRect endFrame = self.view.frame;
   // NSLog(@"Ending Frame: x:%f y:%f height:%f width:%f", endFrame.origin.x, endFrame.origin.y, endFrame.size.height, endFrame.size.width);
    self.view.frame = startFrame;

    
    [UIView animateWithDuration:1.5f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void)
     {
         self.view.frame = endFrame;
         self.titleLabel.frame = endLabelFrame;

     }
                     completion:NULL];
}

@end
