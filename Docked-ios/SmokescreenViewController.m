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
    
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        for (UIView *view2 in view.subviews) {
            if ([view2 isKindOfClass:[UIImageView class]]) {
                [view2 removeFromSuperview];
            }
        }
    }
 
    UIImage * backImage = [UIImage imageNamed:@"menu.png"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:nil action:nil];
    
    UIView* coverUpView = [[UIView alloc] initWithFrame:CGRectMake(0, _cardImageView.frame.size.height -1, _cardImageView.frame.size.width, 1)];/// change size as you need.
    coverUpView.backgroundColor = [UIColor whiteColor];
    
    [_cardImageView addSubview:coverUpView];
    
    [self.view addSubview:_cardImageView];
    
   // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
   
   [UIView animateWithDuration:0.32
                          delay:0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [self.navigationItem setLeftBarButtonItem:nil animated:YES];
                         _cardImageView.frame = CGRectMake(6, 64, 308, _cardImageView.frame.size.height );
                     }
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
