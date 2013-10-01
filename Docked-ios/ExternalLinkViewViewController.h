//
//  ExternalLinkViewViewController.h
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExternalLinkViewViewController : UIViewController

@property (strong, nonatomic) NSString *externalLink;
@property (weak, nonatomic) IBOutlet UIButton *externalLinkButton;

-(void)setExternalLink:(NSString *)newExternalLink;
-(IBAction)didTapExternalLinkButton:(id)sender;

@end
