//
//  TLMasterViewController.m
//  UIViewController-Transitions-Example
//
//  Created by Ash Furrow on 2013-07-12.
//  Copyright (c) 2013 Teehan+Lax. All rights reserved.
//

#import "TLMasterViewController.h"
#import "TLMenuViewController.h"

#import "TLDetailViewController.h"

#import "TLTransitionAnimator.h"
#import "TLMenuInteractor.h"
#import "TLMenuDynamicInteractor.h"
#import "AwesomeTableViewCell.h"




#define USE_UIKIT_DYNAMICS      NO





@interface TLMasterViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) id<TLMenuViewControllerPanTarget> menuInteractor;
@property NSIndexPath *selectedIndexPath;

@end

@implementation TLMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%f %f", [UIApplication sharedApplication].statusBarFrame.size.height, self.navigationController.navigationBar.frame.size.height);
    if (USE_UIKIT_DYNAMICS) {
        self.menuInteractor = [[TLMenuDynamicInteractor alloc] initWithParentViewController:self];
    }
    else {
        self.menuInteractor = [[TLMenuInteractor alloc] initWithParentViewController:self];
    }
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self.menuInteractor action:@selector(presentMenu)];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    UIScreenEdgePanGestureRecognizer *gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self.menuInteractor action:@selector(userDidPan:)];
    gestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:gestureRecognizer];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
    
    TLDetailViewController *detailViewController = segue.destinationViewController;

    detailViewController.transitioningDelegate = self;
    detailViewController.modalPresentationStyle = UIModalPresentationCustom;
    detailViewController.startingPosition = [self.tableView rectForRowAtIndexPath:self.selectedIndexPath];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AwesomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = @"Present view controller";
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIViewControllerTransitioningDelegate Methods

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
//                                                                   presentingController:(UIViewController *)presenting
//                                                                       sourceController:(UIViewController *)source
//{
//    
//    TLTransitionAnimator *animator = [TLTransitionAnimator new];
//    //Configure the animator
//    animator.startingPosition = [self.tableView rectForRowAtIndexPath:self.selectedIndexPath];
//    animator.selectedCell = (AwesomeTableViewCell*)[self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
//    animator.presenting = YES;
//    return animator;
//}
//
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    TLTransitionAnimator *animator = [TLTransitionAnimator new];
//    animator.startingPosition = [self.tableView rectForRowAtIndexPath:self.selectedIndexPath];
//    return animator;
//}

@end


