//
//  SmokescreenViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "SmokescreenViewController.h"

@interface SmokescreenViewController ()

@end

@implementation SmokescreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:_cardImageView];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:0.4
                          delay:0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                        _cardImageView.frame = CGRectMake(6, 60, 308, 140 );                                 }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                         [self dismissViewControllerAnimated:NO completion:nil];
                         [_navController pushViewController:_detailViewController animated:NO];
                         //[self.navigationController popToViewController:_detailViewController animated:NO];
//                         [self dismissViewControllerAnimated:NO completion:nil];
//                         [self.navigationController pushViewController:_detailViewController animated:NO];
                         
                         

                         
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavController:(UINavigationController *)navController
{
     if (_navController != navController) {
         _navController = navController;
     }
 }

- (void)setCardImageView:(UIImageView *)newCard
{
    if (_cardImageView != newCard) {
        _cardImageView = newCard;
    }
}
     


- (void)setDetailViewController:(DetailViewController *)detailVC
{
    if (_detailViewController != detailVC) {
        _detailViewController = detailVC;
    }
}

@end
