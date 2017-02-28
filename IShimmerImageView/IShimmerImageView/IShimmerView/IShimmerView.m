//
//  XYLevelShimmerView.m
//  Examples
//
//  Created by Yaqiang Wang on 17/2/27.
//
//

#import "IShimmerView.h"
@interface IShimmerView()
@property(nonatomic,strong)CADisplayLink *highRankingUserComeDisplayLink;
@property(nonatomic)double fromX;
@property(nonatomic,strong)UIImage *currentImage;
@property(nonatomic)BOOL b ;
@end

@implementation IShimmerView
- (instancetype)initWithImage:(nullable UIImage *)image frame:(CGRect)frame{
  if (self = [super initWithFrame:frame]) {
    self.currentImage = image;
    self.highRankingUserComeDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(highRankingUserComeDisplayLinkMethod)];
    [self.highRankingUserComeDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.highRankingUserComeDisplayLink.frameInterval = 6;
    self.highRankingUserComeDisplayLink.paused = NO;
    self.fromX = 0;

    
  }
  return self;
}
-(void)highRankingUserComeDisplayLinkMethod{
  self.fromX += 2;
  if (self.fromX > 50) {
      self.fromX = 0;
  }
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
   [self.currentImage drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeOverlay alpha:1.0];

  CGContextRef context=UIGraphicsGetCurrentContext();
  //  [self drawLinearGradientTest:context];
  [self drawdrawRadialGradientWithRect:context rect:CGRectMake(self.fromX, 2.5, 6,6 )];
}

- (void)drawdrawRadialGradientWithRect:(CGContextRef)context rect:(CGRect)rect
{
  CGContextSetBlendMode(context, kCGBlendModeOverlay);
  //先创造一个CGGradientRef,颜色是白,黑,location分别是0,1
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  NSArray* gradientColors = [NSArray arrayWithObjects:
                             (id)[UIColor colorWithWhite:1 alpha:1.0].CGColor,
                             (id)[UIColor colorWithWhite:1 alpha:0.2].CGColor, nil];
  CGFloat gradientLocations[] = {0, 1};
  
  CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                      (__bridge CFArrayRef)gradientColors,
                                                      gradientLocations);
  CGPoint startCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
  CGFloat radius = MAX(CGRectGetHeight(rect), CGRectGetWidth(rect));
  
  CGContextDrawRadialGradient(context, gradient,
                              startCenter, 0,
                              startCenter, radius,
                              0);
  
  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);

  //从某一点开始绘制
  [self.currentImage drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeDestinationIn alpha:1.0];//[self.currentImage drawInRect:self.bounds blendMode:kCGBlendModeDestinationIn alpha:1.0];
  
}


@end
