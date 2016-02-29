//
//  ViewController.m
//  PScaleLoading
//
//  Created by on 16-2-26.
//  Copyright (c) 2016年 Carl. All rights reserved.
//

#import "MainViewController.h"
#import "PScaleLoadingView.h"

@interface MainViewController ()

@property (nonatomic,strong) PScaleLoadingView *animationV;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:168/255.f green:169/255.f blue:38/255.f alpha:1.0];
    
    _animationV = [[PScaleLoadingView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _animationV.center = self.view.center;
    [_animationV customAnimations];
    [self.view addSubview:_animationV];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:9 target:self selector:@selector(restartAnimation) userInfo:nil repeats:YES];
    [timer fire];
}

- (void) restartAnimation
{
    [_animationV removeFromSuperview];
    
    PScaleLoadingView *customAnimationV = [[PScaleLoadingView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    customAnimationV.center = self.view.center;
    [customAnimationV customAnimations];
    [self.view addSubview:customAnimationV];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
