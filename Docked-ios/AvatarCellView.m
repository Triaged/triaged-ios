//
//  AvatarCellView.m
//  Triage-ios
//
//  Created by Charlie White on 3/18/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "AvatarCellView.h"

@implementation AvatarCellView

@synthesize largeIcon, smallIcon;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        self.largeIcon = [[UIImageView alloc] initForAutoLayout];
        [self addSubview:self.largeIcon];
        
        self.smallIcon = [[UIImageView alloc] initForAutoLayout];
        [self addSubview:self.smallIcon];
        
        
    }
    return self;
}

- (void)setProvider:(Provider *)provider andUser:(User *)user
{
    
    if (user) {
            [self.largeIcon setImageWithURL:[NSURL URLWithString:user.avatarUrl]
                            placeholderImage:[UIImage imageNamed:@"avatar.png"]];
        
            [self.smallIcon.layer setBorderColor: [[UIColor whiteColor] CGColor]];
            [self.smallIcon.layer setBorderWidth:1.0];
            [self.smallIcon.layer setCornerRadius:8.0];
            [self.smallIcon setImageWithURL:[NSURL URLWithString:provider.largeIcon]];
            [self addSubview:self.smallIcon];
            self.smallIconExists = YES;
        
            
        } else {
            [self.largeIcon setImageWithURL:[NSURL URLWithString:provider.largeIcon]];
            [self.smallIcon removeFromSuperview];
            self.smallIconExists = NO;
        }
}


- (void)updateConstraints {
    
    [super updateConstraints];
    
    if (self.didSetupConstraints) {
        return;
    }

    [self.largeIcon setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [self.largeIcon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.largeIcon autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [self.largeIcon autoSetDimension:ALDimensionHeight toSize:40.0];
    [self.largeIcon autoSetDimension:ALDimensionWidth toSize:40.0];

    if (self.smallIconExists) {
        [self.smallIcon setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        [self.smallIcon autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:27.0];
        [self.smallIcon autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:23.0];
        [self.smallIcon autoSetDimension:ALDimensionHeight toSize:17.0];
        [self.smallIcon autoSetDimension:ALDimensionWidth toSize:17.0];
    }
    
    self.didSetupConstraints = YES;

}

@end
