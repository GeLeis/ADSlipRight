//
//  UIViewController+SMAdvertising.h
//  ADSlipRight
//
//  Created by zhaoP on 16/9/7.
//  Copyright © 2016年 langya. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdvertisingController;
@interface UIViewController (SMAdvertising)<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic,strong) AdvertisingController *advertisingController;
-(void)addAdvertisingController:(AdvertisingController *)viewController;
-(void)recoverAdvertisingController;
@end
