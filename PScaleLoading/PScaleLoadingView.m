//
//  PScaleLoadingView.h
//  testAnimation
//
//  Created by xp_mac on 16/2/26.
//  Copyright © 2016年 xp_mac. All rights reserved.
//

#import "PScaleLoadingView.h"
#import "CustomShapeLayer.h"
#import "DurModel.h"

#define DURATION_TIME 1

@interface PScaleLoadingView ()

@property (nonatomic, strong) NSMutableDictionary * layers;
@property (nonatomic, strong) NSMapTable * completionBlocks;

@end

@implementation PScaleLoadingView

#pragma mark - Animation init

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self setupProperties];
		[self setupLayers];
        
	}
	return self;
}


- (void)setupProperties{
    //初始化数据
	self.completionBlocks = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsOpaqueMemory valueOptions:NSPointerFunctionsStrongMemory];;
	self.layers = [NSMutableDictionary dictionary];
	
}

- (void)setupLayers{
	
    //创建8个自定义的矩形框
    for (int i = 0; i < 8; i++) {
        NSString *shapeLayerName = [NSString stringWithFormat:@"rectangle%d",i+1];
        CustomShapeLayer *rectangle = [[CustomShapeLayer alloc] initTheFrame:CGRectZero withIndex:i+1];
        [self.layer addSublayer:rectangle];
        self.layers[shapeLayerName] = rectangle;
    }
    
    CAShapeLayer * oval = [CAShapeLayer layer];
    oval.frame = CGRectMake(0, 0, 2, 2);
    oval.position = CGPointMake(self.center.x, self.center.y);
    oval.backgroundColor = [UIColor colorWithRed:168/255.f green:169/255.f blue:38/255.f alpha:1.0].CGColor;
    [self.layer addSublayer:oval];
}


#pragma mark - Animation Setup

- (void)customAnimations{

	self.layer.speed = 1;
    
    //创建8个动画模型
    for (int i = 0; i < 8; i++) {
        CABasicAnimation *transformAnimation = [self eachPartAnimation:i];
        NSString *layerNameStr = [NSString stringWithFormat:@"rectangle%d",i+1];
        
        if (i == 0) {
            [self.layers[layerNameStr] addAnimation:transformAnimation forKey:nil];
            [self performSelector:@selector(pauseLayer:) withObject:self.layers[layerNameStr] afterDelay:1];
            [self performSelector:@selector(resumeLayer:) withObject:self.layers[layerNameStr] afterDelay:4.5];
        }
        else
        {
            
            CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
            animationGroup.animations = @[transformAnimation];
            animationGroup.duration   = [DurModel initWithTheDuration:transformAnimation];
            [self.layers[layerNameStr] addAnimation:animationGroup forKey:nil];
            
            [self performSelector:@selector(pauseLayer:) withObject:self.layers[layerNameStr] afterDelay:1+(i)*0.5];
            [self performSelector:@selector(resumeLayer:) withObject:self.layers[layerNameStr] afterDelay:4.5+(i)*0.5];
        }
        
    }
    
    
}

//暂停动画
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

//重新启动动画
-(void)resumeLayer:(CALayer*)layer
{
    
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

//依次索引不同的动画效果
- (CABasicAnimation *) eachPartAnimation:(NSInteger)index
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    switch (index) {
        case 0:
            animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.fromValue      = [NSValue valueWithCATransform3D:CATransform3DIdentity];;
            animation.toValue        = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DMakeScale(30, 30, 30), CATransform3DMakeTranslation(0, -60, 0))];;
            animation.duration       = DURATION_TIME;
            animation.beginTime      = CACurrentMediaTime();
            animation.autoreverses   = YES;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        case 1:
            animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.fromValue      = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-45 * M_PI/180, 0, 0, -1)];;
            animation.toValue        = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeScale(30, 30, 30), CATransform3DMakeTranslation(0, -60, 0)), CATransform3DMakeRotation(45 * M_PI/180, 0, -0, 1))];;
            animation.duration       = DURATION_TIME;
            animation.beginTime      = 0.5;
            animation.autoreverses   = YES;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        case 2:
            animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.fromValue      = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-90 * M_PI/180, 0, 0, -1)];;
            animation.toValue        = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeScale(30, 30, 30), CATransform3DMakeTranslation(0, -60, 0)), CATransform3DMakeRotation(90 * M_PI/180, 0, -0, 1))];;
            animation.duration       = DURATION_TIME;
            animation.beginTime      = 1;
            animation.autoreverses   = YES;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        case 3:
            animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.fromValue      = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(225 * M_PI/180, 0, 0, -1)];;
            animation.toValue        = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeScale(30, 30, 30), CATransform3DMakeTranslation(0, -60, 0)), CATransform3DMakeRotation(-225 * M_PI/180, -0, 0, 1))];;
            animation.duration       = DURATION_TIME;
            animation.beginTime      = 1.5;
            animation.autoreverses   = YES;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        case 4:
            animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.fromValue      = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, -1)];;
            animation.toValue        = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeScale(30, 30, 30), CATransform3DMakeTranslation(0, -60, 0)), CATransform3DMakeRotation(-M_PI, 0, 0, 1))];;
            animation.duration       = DURATION_TIME;
            animation.beginTime      = 2;
            animation.autoreverses   = YES;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        case 5:
            animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.fromValue      = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(135 * M_PI/180, 0, 0, -1)];;
            animation.toValue        = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeScale(30, 30, 30), CATransform3DMakeTranslation(0, -60, 0)), CATransform3DMakeRotation(-135 * M_PI/180, -0, 0, 1))];;
            animation.duration       = DURATION_TIME;
            animation.beginTime      = 2.5;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            animation.autoreverses   = YES;
            break;
        case 6:
            animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.fromValue      = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0, 0, -1)];;
            animation.toValue        = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeScale(30, 30, 30), CATransform3DMakeTranslation(0, -60, 0)), CATransform3DMakeRotation(-M_PI_2, 0, 0, 1))];;
            animation.duration       = DURATION_TIME;
            animation.beginTime      = 3;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            animation.autoreverses   = YES;
            break;
        case 7:
            animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.fromValue      = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 0, 0, -1)];;
            animation.toValue        = [NSValue valueWithCATransform3D:CATransform3DConcat(CATransform3DConcat(CATransform3DMakeScale(30, 30, 30), CATransform3DMakeTranslation(0, -60, 0)), CATransform3DMakeRotation(-M_PI_4, 0, 0, 1))];;
            animation.duration       = DURATION_TIME;
            animation.beginTime      = 3.5;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            animation.autoreverses   = YES;
            break;
        default:
            break;
    }
    
    return animation;
}

#pragma mark - Animation Cleanup

- (void)removeAllAnimations{
	[self.layers enumerateKeysAndObjectsUsingBlock:^(id key, CALayer *layer, BOOL *stop) {
		[layer removeAllAnimations];
	}];
}

@end
