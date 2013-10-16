//
//  GraphDataCell.h
//  Docked-ios
//
//  Created by Charlie White on 9/29/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardCell.h"

@protocol GraphCardProtocol <CardProtocol>
-(NSArray *)chartCoordinates;
-(NSNumber *)firstDataField;
-(NSNumber *)secondDataField;
-(NSNumber *)thirdDataField;
@optional
-(NSString *)body;
@end

@interface GraphDataCellShinobi : CardCell

@end
