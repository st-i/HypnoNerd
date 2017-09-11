//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by iStef on 22.11.16.
//  Copyright © 2016 Stefanov. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UITextField *textField;

@end

@implementation BNRHypnosisViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    [UIView animateWithDuration:2.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:0 animations:^{
        CGRect frame=CGRectMake(40, 70, 240, 30);
        self.textField.frame=frame;
    }completion:NULL];
}

-(void)loadView
{
    //Create a view
    CGRect frame=[UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView=[[BNRHypnosisView alloc]initWithFrame:frame];
    
    CGRect textFieldRect=CGRectMake(0, 70, 240, 30);
    UITextField *textField=[[UITextField alloc]initWithFrame:textFieldRect];
    //Setting the border style on the text field will allow us to see it more easily
    textField.borderStyle=UITextBorderStyleRoundedRect;
    textField.placeholder=@"Hypnotize me";
    textField.returnKeyType=UIReturnKeyDone;
    [backgroundView addSubview:textField];
    
    self.textField=textField;
    
    textField.delegate=self;
    
    //Set it as the "view" of this view controller
    self.view=backgroundView;
}

-(void)drawHypnoticMessage:(NSString *)message
{
    for (int i=0; i<5; i++) {
        UILabel *messageLabel=[[UILabel alloc]init];
        
        messageLabel.backgroundColor=[UIColor clearColor];
        messageLabel.textColor=[UIColor blackColor];
        messageLabel.text=message;
        
        [messageLabel sizeToFit];
        
        int width=(int)(self.view.bounds.size.width-messageLabel.bounds.size.width);
        int x=arc4random()%width;
        
        int height=(int)(self.view.bounds.size.height-messageLabel.bounds.size.height);
        int y=arc4random()%height;
        
        CGRect mesFrame=messageLabel.frame;
        mesFrame.origin=CGPointMake(x, y);
        messageLabel.frame=mesFrame;
        
        [self.view addSubview:messageLabel];
        
        //[UIView animateWithDuration:1.5 animations:^{
        //messageLabel.alpha=1.0;
        //}];
        
        [UIView animateWithDuration:1.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
         messageLabel.alpha=1.0;
         }
         completion:NULL];
         
         [UIView animateKeyframesWithDuration:1.5 delay:0.0 options:0 animations:^{
         [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.8 animations:^{
         messageLabel.center=self.view.center;
         }];
         
         [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.7 animations:^{
         int x=arc4random()%width;
         int y=arc4random()%height;
         messageLabel.center=CGPointMake(x, y);
         }];
         
         }completion:^(BOOL finished){
         NSLog(@"Animation finished!");
         }];
        
        
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect=[[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue=@(-25);
        motionEffect.maximumRelativeValue=@(25);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect=[[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue=@(-25);
        motionEffect.maximumRelativeValue=@(25);
        [messageLabel addMotionEffect:motionEffect];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //NSLog(@"%@", textField.text);
    [self drawHypnoticMessage:textField.text];
    
    textField.text=@"";
    [textField resignFirstResponder];
    return YES;
}

/*-(void)clearButtonTapped
{
    SEL clearSelector=@selector(textFieldShouldClear:);
    
    if ([self respondsToSelector:clearSelector]) {
        if ([self.delegate textFieldShouldClear:self]) {
        }
    }
}*/

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title=@"Hypnosis";
        
        UIImage *i=[UIImage imageNamed:@"Hypno.png"];
        self.tabBarItem.image=i;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"BNRHypnosisViewController loaded its view!");
}

@end
