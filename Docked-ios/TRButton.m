//
//  TRButton.m
//  Triage-ios
//
//  Created by Charlie White on 11/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "TRButton.h"

@implementation TRButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = TINT_COLOR;
        
        [self.layer setCornerRadius:4.0f];
        [self.layer setMasksToBounds:YES];
        
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

@end
