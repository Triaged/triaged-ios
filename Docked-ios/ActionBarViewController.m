//
//  ExternalLinkViewViewController.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "ActionBarViewController.h"
#import "DetailViewController.h"
#import "SVProgressHUD.h"
#import "NSString+Inflections.h"
#import "ActionCell.h"

@interface ActionBarViewController () {
    NSArray *actions;
    UITableView *_tableView;
}

@end

@implementation ActionBarViewController

@synthesize screenShot, feedItem;

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
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor =  [UIColor whiteColor];//[[UIColor alloc] initWithRed:249.0f/255.0f green:249.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
//    self.view.backgroundColor = [[UIColor alloc] initWithRed:122.0f/255.0f green:141.0f/255.0f blue:196.0f/255.0f alpha:0.6f];
    
    
    
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    
    actions = @[
                @{@"label" : @"Explore in safari", @"icon" : @"icn_explore.png" },
                @{@"label" : @"Share via email", @"icon" : @"icn_share-up.png" },
            ];
    
    self.view.layer.shadowOffset = CGSizeMake(0, 1);
    self.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.view.layer.shadowRadius = 3;
    self.view.layer.shadowOpacity = .5;
    CGRect shadowFrame =  CGRectMake(self.view.layer.bounds.origin.x, self.view.layer.bounds.origin.y + self.view.layer.bounds.size.height, self.view.layer.bounds.size.width, 2);
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
    self.view.layer.shadowPath = shadowPath;

}

-(void) viewWillLayoutSubviews
{
    [_tableView reloadData];
    [_tableView layoutIfNeeded];
    CGRect frame = CGRectMake(0, _tableView.frame.origin.y, self.view.frame.size.width, [_tableView contentSize].height);
    _tableView.frame = frame;

    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, _tableView.frame.size.height);
}


-(void) disableAllActions
{
    self.view.userInteractionEnabled = NO;
}
-(void) enableAllActions
{
    self.view.userInteractionEnabled = YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 2; //actions.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"ActionCell";
    ActionCell *cell = [ tableView dequeueReusableCellWithIdentifier:CellIdentifier ] ;
    if ( !cell )
    {
        cell = [ [ ActionCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ] ;
    }
    
    NSDictionary *actionDict = actions[indexPath.row];
    
    [cell configureForItem:actionDict];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self didTapExternalLinkButton];
    } else {
        [self didTapShareButton];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(IBAction)didTapExternalLinkButton
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[feedItem htmlUrl]]];
}


-(IBAction)didTapShareButton
{
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:@"<html><body><p></p><br />", screenShot, nil] applicationActivities:nil];
//    activityVC.excludedActivityTypes = @[ UIActivityTypeAddToReadingList, UIActivityTypePostToTwitter, UIActivityTypePostToFacebook, UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
//    [self presentViewController:activityVC animated:YES completion:nil];
    
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:[[NSString stringWithFormat:@"%@ %@", feedItem.provider, feedItem.action] humanize]];
    // Attach an image to the email
    
    
    NSLog(@"height: %f", screenShot.size.height);
    NSLog(@"width: %f", screenShot.size.width);
    UIImage *croppedScreenShot = [self imageWithBorderFromImage:screenShot];

    NSData *imageData = UIImageJPEGRepresentation(croppedScreenShot, 1.0);
	[picker addAttachmentData:imageData mimeType:@"image/jpeg" fileName:@"screenshot"];
	
	// Fill out the email body text
	NSString *emailBody = @"";
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentViewController:picker animated:YES completion:NULL];

}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    
    NSLog(@"height: %f", cropped.size.height);
    NSLog(@"width: %f", cropped.size.width);

    
    return cropped;
}

- (UIImage*)imageWithBorderFromImage:(UIImage*)source;
{
    
    //source = [self imageByCropping:source toRect:CGRectMake(0, 0, source.size.width, source.size.height)];
    
    CGSize size = [source size];
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [source drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 239.0/255.0, 240.0/255.0, 245.0/255.0, 1.0);
    //[[UIColor alloc] initWithRed:239.0f/255.0f green:240.0f/255.0f blue:245.0f/255.0f alpha:1.0f];

    CGContextStrokeRect(context, rect);
    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return testImg;
}
@end
