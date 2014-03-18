//
//  ContainerViewCell.m
//  Triage-ios
//
//  Created by Charlie White on 3/17/14.
//  Copyright (c) 2014 Charlie White. All rights reserved.
//

#import "ContainerViewCell.h"

@implementation ContainerViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self.layer setBorderWidth:0.5f];
        UIColor *borderColor = BORDER_COLOR;
        [self.layer setBorderColor:borderColor.CGColor];
        [self.layer setCornerRadius:4.0f];
        [self.layer setMasksToBounds:YES];
        self.backgroundColor = [UIColor whiteColor];
        
        self.userInteractionEnabled = NO;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setBottomCornersStraight {
    [self.layer setCornerRadius:0.0f];
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(4.0, 4.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


- (void)setAllCornersRounded {
    [self.layer setCornerRadius:4.0f];
}

@end
