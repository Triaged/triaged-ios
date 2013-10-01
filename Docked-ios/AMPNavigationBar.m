//
//  AMPNavigationBar.m
//  Docked-ios
//
//  Created by Charlie White on 9/30/13.
//  Copyright (c) 2013 Charlie White. All rights reserved.
//

#import "AMPNavigationBar.h"

@interface AMPNavigationBar ()

@property (nonatomic, strong) CALayer *extraColorLayer;

@end

static CGFloat const kDefaultColorLayerOpacity = 0.5f;

@implementation AMPNavigationBar

- (void)setBarTintColor:(UIColor *)barTintColor
{
    [super setBarTintColor:barTintColor];
	if (self.extraColorLayer == nil) {
		self.extraColorLayer = [CALayer layer];
		self.extraColorLayer.opacity = self.extraColorLayerOpacity;
		[self.layer addSublayer:self.extraColorLayer];
	}
	self.extraColorLayer.backgroundColor = barTintColor.CGColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
	if (self.extraColorLayer != nil) {
		[self.extraColorLayer removeFromSuperlayer];
		self.extraColorLayer.opacity = self.extraColorLayerOpacity;
		[self.layer insertSublayer:self.extraColorLayer atIndex:1];
		CGFloat spaceAboveBar = self.frame.origin.y;
		self.extraColorLayer.frame = CGRectMake(0, 0 - spaceAboveBar, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + spaceAboveBar);
	}
}

- (void)setExtraColorLayerOpacity:(CGFloat)extraColorLayerOpacity
{
    _extraColorLayerOpacity = extraColorLayerOpacity;
	[self setNeedsLayout];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        _extraColorLayerOpacity = [[decoder decodeObjectForKey:@"extraColorLayerOpacity"] floatValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
	[super encodeWithCoder:encoder];
	[encoder encodeObject:@(self.extraColorLayerOpacity) forKey:@"extraColorLayerOpacity"];
}

@end

//// the easy way to use it is to subclass UINavigationController and override:
//- (id)initWithRootViewController:(UIViewController *)rootViewController
//{
//    self = [super initWithNavigationBarClass:[APNavigationBar class] toolbarClass:[UIToolbar class]];
//    if (self) {
//        self.viewControllers = @[ rootViewController ];
//    }
//    return self;
//}
