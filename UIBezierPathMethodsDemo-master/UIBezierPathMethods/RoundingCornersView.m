//
//  RoundingCornersView.m
//  UIBezierPathMethods
//
//  Created by 劉光軍 on 2016/11/10.
//  Copyright © 2016年 劉光軍. All rights reserved.
//

#import "RoundingCornersView.h"

@interface UIView (CornerRadius)
- (void)addCorner:(UIRectCorner)corners cornerRadii:(CGFloat)radius;
- (void)setBorder:(CGFloat)boderWidth borderColor:(UIColor*)color;
@end
@implementation RoundingCornersView
- (instancetype)initWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor orangeColor];
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *tempLb  = [[UILabel alloc]initWithFrame:CGRectZero];
        tempLb.text = @"temp";
        tempLb.font = [UIFont boldSystemFontOfSize:30];
        tempLb.textColor = [UIColor greenColor];
        tempLb.textAlignment = NSTextAlignmentCenter;
        [tempLb sizeToFit];
        tempLb.frame = CGRectMake(10,10, tempLb.bounds.size.width, tempLb.bounds.size.height);
        [self addSubview:tempLb];
    }
    
    [self setBorder:5 borderColor:[UIColor orangeColor]];
    [self addCorner: UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:15];
    return self;
}

//- (void)drawRect:(CGRect)rect {
//    
//    UIColor *color = [UIColor redColor];
//    [color set];
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect)) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
//    
//    path.lineCapStyle = kCGLineCapRound;
//    path.lineJoinStyle = kCGLineJoinRound;
//    path.lineWidth = 5.0;
//    
//    [path stroke];
//    
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.path = path.CGPath;
//    self.layer.mask = maskLayer;
//}

@end

@implementation UIView (CornerRadius)
- (void)addCorner:(UIRectCorner)corners cornerRadii:(CGFloat)radius size:(CGSize)viewSize{
    CGRect rect = CGRectMake(0, 0, viewSize.width, viewSize.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];

    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 1.0;

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

- (void)addCorner:(UIRectCorner)corners cornerRadii:(CGFloat)radius{
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
#if DEBUG
        NSLog(@"frame尺寸为0,请注意检查");
#endif
    }
    [self addCorner:corners cornerRadii:radius size:self.frame.size];
}

- (void)setBorder:(CGFloat)boderWidth borderColor:(UIColor*)color{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = boderWidth;
}

// 截屏
- (UIImage*)screenshot{
    //生成图片
    //1.开启一个位图上下文
    UIGraphicsBeginImageContext(self.bounds.size);
    //2.把View的内容绘制到上下文当中
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    //UIView内容想要绘制到上下文当中, 必须使用渲染的方式
    [self.layer renderInContext:ctx];
    //3.从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭上下文
    UIGraphicsEndImageContext();
    //把图片转成二进制流
//    //NSData *data = UIImageJPEGRepresentation(newImage, 1);
//    NSData *data = UIImagePNGRepresentation(newImage);
//    
//    [data writeToFile:@"/Users/lifengfeng/Downloads/imlifengfeng.jpg" atomically:YES];
    return newImage;;
}


@end

@interface UIImage(WaterMask)
- (UIImage*)addWaterMask:(NSString*)txt;
@end
@implementation UIImage(WaterMask)

- (UIImage*)addWaterMask:(NSString*)txt{
    //1.创建位图上下文(size:开启多大的上下文,就会生成多大的图片)
    UIGraphicsBeginImageContext(self.size);
    //2.把图片绘制到上下文当中
    [self drawAtPoint:CGPointZero];
    //3.绘制水印(虽说UILabel可以快速实现这种效果，但是我们也可以绘制出来)
    NSString *str = txt;
    
    // 水印的 字体、颜色等样式 根据项目 按需调整
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    
    [str drawAtPoint:CGPointZero withAttributes:dict];
    //4.从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭位图上下文
    UIGraphicsEndImageContext();
    return newImage;
}

@end

@interface UIView(ScreenShot)
- (UIImage*)screenshot;
@end
@implementation UIView(ScreenShot)
- (UIImage*)screenshot{
    //生成图片
    //1.开启一个位图上下文
    UIGraphicsBeginImageContext(self.bounds.size);
    //2.把View的内容绘制到上下文当中
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    //UIView内容想要绘制到上下文当中, 必须使用渲染的方式
    [self.layer renderInContext:ctx];
    //3.从上下文当中生成一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭上下文
    UIGraphicsEndImageContext();
    //把图片转成二进制流
//    //NSData *data = UIImageJPEGRepresentation(newImage, 1);
//    NSData *data = UIImagePNGRepresentation(newImage);
//
//    [data writeToFile:@"/Users/lifengfeng/Downloads/imlifengfeng.jpg" atomically:YES];
    return newImage;
}

@end
