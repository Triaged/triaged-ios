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
    UIImage * shareImage = [UIImage imageNamed:@"icn_share.png"];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:shareImage style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = shareButton;
    
    UIImage * backImage = [UIImage imageNamed:@"icn_back.png"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [self.view addSubview:_cardImageView];
    
   // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [UIView animateWithDuration:0.35
                          delay:0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                        _cardImageView.frame = CGRectMake(6, 63, 308, _cardImageView.frame.size.height );                                 }
                     completion:^(BOOL finished){
                         [self dismissViewControllerAnimated:NO completion:nil];
                         [_navController pushViewController:_detailViewController animated:NO];
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
