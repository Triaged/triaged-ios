//
//  TextCardCell.h
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardCell.h"

@protocol TextCardProtocol <CardProtocol>
-(NSString *)body;
@end

@interface TextCardCell : CardCell

@end
