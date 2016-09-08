//
//  UIViewController+SMAdvertising.m
//  ADSlipRight
//
//  Created by zhaoP on 16/9/7.
//  Copyright © 2016年 langya. All rights reserved.
//

#import "UIViewController+SMAdvertising.h"
#import "AdvertisingController.h"
#import <objc/runtime.h>

@implementation UIViewController (SMAdvertising)

static char advertisingViewKey,translateXKey,panGestureRecognizerKey,advertisingControllerKey;


-(void)setAdvertisingView:(UIView *)advertisingView{
	objc_setAssociatedObject(self, &advertisingViewKey, advertisingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)advertisingView{
	return objc_getAssociatedObject(self, &advertisingViewKey);
}

-(void)setTranslateX:(NSNumber *)translateX{
	objc_setAssociatedObject(self, &translateXKey, translateX, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber *)translateX{
	return objc_getAssociatedObject(self, &translateXKey);
}

-(UIPanGestureRecognizer *)panGestureRecognizer{
	return objc_getAssociatedObject(self, &panGestureRecognizerKey);
}
-(void)setPanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer{
	return objc_setAssociatedObject(self, &panGestureRecognizerKey, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(AdvertisingController *)advertisingController{
	return objc_getAssociatedObject(self, &advertisingControllerKey);
}

-(void)setAdvertisingController:(AdvertisingController *)advertisingController{
	objc_setAssociatedObject(self, &advertisingControllerKey, advertisingController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)addAdvertisingController:(AdvertisingController *)viewController{
	self.advertisingController = viewController;
	self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
	
	self.panGestureRecognizer.delegate = self;
	[self.view addGestureRecognizer:self.panGestureRecognizer];
	
	self.advertisingView = viewController.view;
	self.advertisingView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
	[self.view addSubview:self.advertisingView];
}


-(void)didPan:(UIPanGestureRecognizer *)pan{
	CGPoint translate;
	if (pan.state == UIGestureRecognizerStateBegan) {
		self.translateX = @(0);
		[self.advertisingController loadAdverting];
	}else if (pan.state == UIGestureRecognizerStateChanged) {
		translate = [pan translationInView:self.view];
		self.translateX = @(translate.x + self.translateX.floatValue);
		if (self.advertisingView.frame.origin.x == 0) {
			if (self.translateX.floatValue < - 30) {
				[self recoverAdvertisingController];
			}
			return;
		}else{
			CGRect frame = self.advertisingView.frame;
			self.advertisingView.frame = CGRectMake(frame.origin.x + translate.x, 0, frame.size.width, frame.size.height);
		}
		[pan setTranslation:CGPointZero inView:self.view];
		
	}else if (pan.state == UIGestureRecognizerStateEnded) {
		__weak typeof(self) weakSelf = self;
		if (self.translateX.floatValue > [UIScreen mainScreen].bounds.size.width * 0.4) {
			[UIView animateWithDuration:([UIScreen mainScreen].bounds.size.width - self.translateX.floatValue)/[UIScreen mainScreen].bounds.size.width animations:^{
				weakSelf.advertisingView.frame = weakSelf.view.frame;
			}];
		}else{
			
			[UIView animateWithDuration:self.translateX.floatValue/[UIScreen mainScreen].bounds.size.width animations:^{
				weakSelf.advertisingView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
			}];
		}
		self.translateX = @0;
	}
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
	CGPoint location = [gestureRecognizer locationInView:self.view];
	if (location.x < 64 && self.advertisingView.frame.origin.x != 0) {
		return YES;
	}else if (self.advertisingView.frame.origin.x == 0){
		return YES;
	}else {
		return NO;
	}
}

-(void)recoverAdvertisingController{
	self.view.userInteractionEnabled = NO;
	__weak typeof(self) weakSelf = self;
	[UIView animateWithDuration:0.5 animations:^{
		weakSelf.advertisingView.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
	} completion:^(BOOL finished) {
		weakSelf.view.userInteractionEnabled = YES;
	}];
}

@end
