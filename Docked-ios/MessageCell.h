//
//  MessageCell.h
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

@end
