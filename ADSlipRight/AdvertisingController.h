//
//  AdvertisingController.h
//  ADSlipRight
//
//  Created by zhaoP on 16/9/7.
//  Copyright © 2016年 langya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisingController : UIViewController
@property (nonatomic,strong) void (^clickAdvertisingAction)();
-(void)loadAdverting;
@end
