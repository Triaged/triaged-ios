//
//  ProviderSettingsViewController.m
//  Docked-ios
//
//

#import "ProviderSettingsViewController.h"
#import "AppDelegate.h"
#import "Store.h"
#import "SVProgressHUD.h"
#import "UIImageView+AFNetworking.h"



@interface ProviderSettingsViewController ()

@end

@implementation ProviderSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.provider = [[AppDelegate sharedDelegate].store.account providerWithName:@"github"];
        self.oAuthController = YES;
        self.eventsViewController.events = [NSArray arrayWithObjects:@[@"Push", @NO], @[@"Commits", @NO], @[@"Issue opened", @YES], @[@"Issue closed", @NO], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.providerHeroImageView setImageWithURL:[NSURL URLWithString:self.provider.largeIcon ] ];
//    self.providerHeroImageView.image = [UIImage image  self.provider.largeIcon];
    
    // Connected State
    //([self isConnected] ?  [self setupConnectedState] : [self setupUnconnectedState]);
    [self setupUnconnectedState];
    }

- (void) setupUnconnectedState
{
    [super setupUnconnectedState];
    
    [self.connectButton setBackgroundColor:[UIColor blackColor]];
    [self.connectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.connectButton setTitle:@"Connect to SOMETHING" forState:UIControlStateNormal];
    [self.scrollView addSubview:self.connectButton];
    
    self.eventsViewController.view.frame = CGRectMake(0, 220, 320, 200);
    [self.scrollView addSubview:self.eventsViewController.view];

    
}

- (void) setupConnectedState
{
    [super setupConnectedState];
    
    self.eventsViewController.view.frame = CGRectMake(0, 260, 320, 200);
    [self.scrollView addSubview:self.eventsViewController.view];
}


- (void)connect
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@", BASE_URL, @"/services/authenticate_for/", self.provider.oauthPath];
    OAuthViewController * oAuthVC = [[OAuthViewController alloc] initWitURL:url];
    oAuthVC.delegate = self;
    [self.navigationController presentViewController:oAuthVC animated:YES completion:nil];
}

-(void) oAuthRequestDidSucceed
{
    [self setupConnectedState];
}

-(void) oAuthRequestDidFail
{
    [SVProgressHUD showErrorWithStatus:@"Something went wrong!"];
}

@end