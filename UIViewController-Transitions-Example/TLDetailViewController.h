//
//  TLDetailViewController.h
//  UIViewController-Transitions-Example
//
//  Created by Ash Furrow on 2013-07-12.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) CGRect startingPosition;
@property (strong, nonatomic) IBOutlet UIView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *buttonLabel;

@end
