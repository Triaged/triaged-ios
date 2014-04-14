//
//  TeammateHeaderViewController.m
//  Triage-ios
//
//  Created by Charlie White on 3/3/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "TeammateHeaderViewController.h"
#import "UIImageView+AFNetworking.h"

@interface TeammateHeaderViewController ()

@end

@implementation TeammateHeaderViewController

@synthesize user, nameLabel, avatarIcon;

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    nameLabel.text = user.name;
    NSURL *avatarUrl = [NSURL URLWithString:user.avatarUrl];
    [avatarIcon setImageWithURL:avatarUrl placeholderImage:[UIImage imageNamed:@"avatar"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
