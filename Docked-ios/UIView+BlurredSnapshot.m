//
//  UIImage+ImageEffects.m
//  Triage-ios
//
//  Created by Charlie White on 10/24/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "UIView+BlurredSnapshot.h"
#import "UIImage+ImageEffects.h"

@implementation UIView (BlurredSnapshot)

-(UIImage *)blurredSnapshot
{
    // Create the image context
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, self.window.screen.scale);
    
    // There he is! The new API method
    [self drawViewHierarchyInRect:self.frame afterScreenUpdates:NO];
    
    // Get the snapshot
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Now apply the blur effect using Apple's UIImageEffect category
    UIImage *blurredSnapshotImage = [snapshotImage applyLightEffect];
    
    // Or apply any other effects available in "UIImage+ImageEffects.h"
    //UIImage *blurredSnapshotImage = [snapshotImage applyDarkEffect];
    // UIImage *blurredSnapshotImage = [snapshotImage applyExtraLightEffect];
    
    // Be nice and clean your mess up
    UIGraphicsEndImageContext();
    
    return blurredSnapshotImage;
}

@end
