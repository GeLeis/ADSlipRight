//
//  AdvertisingController.m
//  ADSlipRight
//
//  Created by zhaoP on 16/9/7.
//  Copyright © 2016年 langya. All rights reserved.
//

#import "AdvertisingController.h"

@implementation AdvertisingController

-(instancetype)init{
	return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AdvertisingController"];
}

- (IBAction)clickAdvertising:(id)sender {
	if (self.clickAdvertisingAction) {
		self.clickAdvertisingAction();
	}
}

-(void)loadAdverting{
	self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
}

@end
