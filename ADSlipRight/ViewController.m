//
//  ViewController.m
//  ADSlipRight
//
//  Created by zhaoP on 16/9/7.
//  Copyright © 2016年 langya. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+SMAdvertising.h"
#import "AdvertisingController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	AdvertisingController *adVC = [[AdvertisingController alloc] init];
	__weak typeof(self) weakSelf = self;
	adVC.clickAdvertisingAction = ^(){
		[weakSelf recoverAdvertisingController];
	};
	[self addAdvertisingController:adVC];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
