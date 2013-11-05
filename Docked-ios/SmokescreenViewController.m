//
//  SmokescreenViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "SmokescreenViewController.h"

@interface SmokescreenViewController () {
    UIImageView *messageToolbarView;
    UIBarButtonItem *backButton;
}

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
    
    //self.navigationItem.hidesBackButton = YES;
    
    backButton = self.navigationItem.backBarButtonItem;
    
//    UIImage * backImage = [UIImage imageNamed:@"cog.png"];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:nil action:nil];
//    self.navigationItem.leftBarButtonItem.title = @"back";
//    
    // Card View
    UIView* coverUpView = [[UIView alloc] initWithFrame:CGRectMake(0, _cardImageView.frame.size.height -1, _cardImageView.frame.size.width, 1)];/// change size as you need.
    coverUpView.backgroundColor = [UIColor whiteColor];
    [_cardImageView addSubview:coverUpView];
    [self.view addSubview:_cardImageView];
    
    //Message Toolbar
    UIImage *messageToolbar = [UIImage imageNamed:@"discuss_animate.png"];
    messageToolbarView = [[UIImageView alloc] initWithImage:messageToolbar];
    messageToolbarView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height, self.view.frame.size.width, 40);
    [self.view addSubview:messageToolbarView];
    
   // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    
    self.navigationItem.leftBarButtonItems = nil;
    [self.navigationItem setBackBarButtonItem:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationItem.leftBarButtonItems = nil;
    [self.navigationItem setBackBarButtonItem:nil];

    
    
    if ( _cardImageView.frame.origin.y > 60 &&  _cardImageView.frame.origin.y < 70) {
        [self.navigationController popViewControllerAnimated:NO];
        _detailViewController.actionBarVC.screenShot = _cardImageView.image;
        [_navController pushViewController:_detailViewController animated:NO];
    } else {
        [UIView animateWithDuration:0.32
                              delay:0
                            options: UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             //self.navigationItem.backBarButtonItem = backButton;

                             
                             _cardImageView.frame = CGRectMake(8, 64, 304, _cardImageView.frame.size.height );
                             
                             messageToolbarView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height - 40, self.view.frame.size.width, 40);

                         }
                         completion:^(BOOL finished){
                             [self.navigationController popViewControllerAnimated:NO];
                             _detailViewController.actionBarVC.screenShot = _cardImageView.image;
                             [_navController pushViewController:_detailViewController animated:NO];
                         }];
    }
   
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
