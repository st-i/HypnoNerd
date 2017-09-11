//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by iStef on 18.11.16.
//  Copyright © 2016 Stefanov. All rights reserved.
//

/*Chapter 4, Gold Challenge______________________________________________________________________*/

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

@property(nonatomic, strong) UIColor *circleColor;

@end

@implementation BNRHypnosisView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGRect bounds=self.bounds;
    
    //Figure out the center of the bounds rectangle
    CGPoint center;
    center.x=bounds.origin.x+bounds.size.width/2.0;
    center.y=bounds.origin.y+bounds.size.height/2.0;
    
    //The circle will be the largest that will fit in the view
    //float radius=(MIN(bounds.size.width, bounds.size.height)/2.0);
    
    //The largest circle will circumscribe the view
    float maxRadius=hypot(bounds.size.width, bounds.size.height)/2.0;
    
    UIBezierPath *path=[[UIBezierPath alloc]init];
    
    //Add an arc to the path at center, with radius of radius, from 0 to 2*PI radians (a circle)
    //[path addArcWithCenter:center
    //radius:radius
    //startAngle:0.0
    //endAngle:M_PI*2
    //clockwise:YES];
    
    for (float currentRadius=maxRadius; currentRadius>0; currentRadius-=20) {
        [path moveToPoint:CGPointMake(center.x+currentRadius, center.y)];
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI*2
                     clockwise:YES];
    }
    
    //Configure line width to 10 points
    path.lineWidth=10;
    //Configure the drawing color to light gray
    [self.circleColor setStroke];
    //Draw the line
    [path stroke];
    
    
    /*CGContextRef currentContext=UIGraphicsGetCurrentContext();
    //It is important to place the save in front of the part which contains clipping path
    CGContextSaveGState(currentContext);
    
    UIBezierPath *trianglePath=[[UIBezierPath alloc]init];
    
    CGPoint triangleOne=CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect)+100);
    CGPoint triangleTwo=CGPointMake(CGRectGetMaxX(rect)-50, CGRectGetMaxY(rect)-100);
    CGPoint triangleThree=CGPointMake(CGRectGetMinX(rect)+50, CGRectGetMaxY(rect)-100);
    [trianglePath moveToPoint:triangleOne];
    [trianglePath addLineToPoint:triangleTwo];
    [trianglePath addLineToPoint:triangleThree];
    [trianglePath addClip];
    
    CGFloat locations[2]={0.0, 1.0};
    CGFloat components[8]={0.0, 1.0, 0.0, 1.0, //start color is green
        1.0, 0.0, 1.0, 1.0}; //End color is yellow
    
    CGColorSpaceRef colorspace=CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient=CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    
    CGPoint startPoint=CGPointMake(0, 0);
    CGPoint endPoint=CGPointMake(bounds.size.width, bounds.size.height);
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    //Important to place the restore in front of the "logo code". Otherwise it will be clipped as well
    CGContextRestoreGState(currentContext);
    
    UIImage *logoImage=[UIImage imageNamed:@"logo.png"];
    
    float rectWidth=220;
    float rectHeight=320;
    
    CGPoint rectOrigin;
    rectOrigin.x=((bounds.origin.x+bounds.size.width)-rectWidth)/2;
    rectOrigin.y=((bounds.origin.y+bounds.size.height)-rectHeight)/2;
    CGRect someRect=CGRectMake(rectOrigin.x, rectOrigin.y, rectWidth, rectHeight);
    CGSize currentOffset=CGSizeMake(4, 7);
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, currentOffset, 3);
    [logoImage drawInRect:someRect];
    CGContextRestoreGState(currentContext);*/
    
    //NSString *str=@"Боря, учи английский! :)";
    //NSDictionary *dict=@{@"b": str};
    //float rectWidth=220;
    //float rectHeight=320;
    //CGPoint rectOrigin;
    //rectOrigin.x=((bounds.origin.x+bounds.size.width)-rectWidth)/2;
    //rectOrigin.y=((bounds.origin.y+bounds.size.height)-rectHeight)/2;
    //CGRect someRect=CGRectMake(rectOrigin.x, rectOrigin.y, rectWidth, rectHeight);
    //[str drawInRect:someRect withAttributes:dict];
    

    //CGContextRef triangle=UIGraphicsGetCurrentContext();
    
    //CGContextBeginPath(triangle);
    //CGContextMoveToPoint(triangle, CGRectGetMinX(rect), CGRectGetMinY(rect));
    //CGContextMoveToPoint(triangle, CGRectGetMaxX(rect), CGRectGetMidY(rect));
    //CGContextMoveToPoint(triangle, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    //CGContextClosePath(triangle);
    
    //CGContextSetRGBFillColor(triangle, 1, 1, 0, 1);
    //CGContextFillPath(triangle);
    
    //Create CAShapeLayer with this triangular path
    //Same size as the original imageView
    //CAShapeLayer *mask=[CAShapeLayer layer];
    //mask.frame=self.bounds;
    //mask.path=path.CGPath;
}

//When a finger touches the screen
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    
    //Get 3 random numbers between 0 and 1
    float red=(arc4random()%100)/100.00;
    float green=(arc4random()%100)/100.00;
    float blue=(arc4random()%100)/100.00;
    
    UIColor *randomColor=[UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    self.circleColor=randomColor;
}

-(void)setCircleColor:(UIColor *)circleColor
{
    _circleColor=circleColor;
    [self setNeedsDisplay];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        //All BNRHypnosisViews start with a clear background color
        self.backgroundColor=[UIColor clearColor];
        self.circleColor=[UIColor lightGrayColor];
    }
    return self;
}

@end

/*Chapter 4, Bronze Challenge______________________________________________________________________

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGRect bounds=self.bounds;
    
    //Figure out the center of the bounds rectangle
    CGPoint center;
    center.x=bounds.origin.x+bounds.size.width/2.0;
    center.y=bounds.origin.y+bounds.size.height/2.0;
    
    //The circle will be the largest that will fit in the view
    //float radius=(MIN(bounds.size.width, bounds.size.height)/2.0);
    
    //The largest circle will circumscribe the view
    float maxRadius=hypot(bounds.size.width, bounds.size.height)/2.0;
    
    UIBezierPath *path=[[UIBezierPath alloc]init];
    
    //Add an arc to the path at center, with radius of radius, from 0 to 2*PI radians (a circle)
    //[path addArcWithCenter:center
    //radius:radius
    //startAngle:0.0
    //endAngle:M_PI*2
    //clockwise:YES];
    
    for (float currentRadius=maxRadius; currentRadius>0; currentRadius-=20) {
        [path moveToPoint:CGPointMake(center.x+currentRadius, center.y)];
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI*2
                     clockwise:YES];
    }
    
    //Configure line width to 10 points
    path.lineWidth=10;
    //Configure the drawing color to light gray
    [[UIColor lightGrayColor]setStroke];
    //Draw the line
    [path stroke];
    
    UIImage *logoImage=[UIImage imageNamed:@"logo.png"];
    
    float rectWidth=220;
    float rectHeight=320;
    
    CGPoint rectOrigin;
    rectOrigin.x=((bounds.origin.x+bounds.size.width)-rectWidth)/2;
    rectOrigin.y=((bounds.origin.y+bounds.size.height)-rectHeight)/2;
    
    CGRect someRect=CGRectMake(rectOrigin.x, rectOrigin.y, rectWidth, rectHeight);
    [logoImage drawInRect:someRect];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        //All BNRHypnosisViews start with a clear background color
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

@end*/

/*Chapter 4________________________________________________________________________________________

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGRect bounds=self.bounds;
    
    //Figure out the center of the bounds rectangle
    CGPoint center;
    center.x=bounds.origin.x+bounds.size.width/2.0;
    center.y=bounds.origin.y+bounds.size.height/2.0;
    
    //The circle will be the largest that will fit in the view
    //float radius=(MIN(bounds.size.width, bounds.size.height)/2.0);
    
    //The largest circle will circumscribe the view
    float maxRadius=hypot(bounds.size.width, bounds.size.height)/2.0;
    
    UIBezierPath *path=[[UIBezierPath alloc]init];
    
    //Add an arc to the path at center, with radius of radius, from 0 to 2*PI radians (a circle)
    //[path addArcWithCenter:center
                    //radius:radius
                //startAngle:0.0
                  //endAngle:M_PI*2
                 //clockwise:YES];
    
    for (float currentRadius=maxRadius; currentRadius>0; currentRadius-=20) {
        [path moveToPoint:CGPointMake(center.x+currentRadius, center.y)];
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI*2
                     clockwise:YES];
    }
    
    //Configure line width to 10 points
    path.lineWidth=10;
    //Configure the drawing color to light gray
    [[UIColor lightGrayColor]setStroke];
    //Draw the line
    [path stroke];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        //All BNRHypnosisViews start with a clear background color
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

@end*/
