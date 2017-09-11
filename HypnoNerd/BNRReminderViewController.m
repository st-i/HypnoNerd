//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by iStef on 23.11.16.
//  Copyright © 2016 Stefanov. All rights reserved.
//

#import "BNRReminderViewController.h"
@import UserNotifications;

@interface BNRReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

-(IBAction)addReminder:(id)sender
{
    NSDate *date=self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
    
    UNUserNotificationCenter *center=[UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options=UNAuthorizationOptionBadge+UNAuthorizationOptionAlert;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"Something went wrong!");
        }
    }];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus!=UNAuthorizationStatusAuthorized) {
            NSLog(@"Notifications are not allowed!");
        }
    }];
    
    UNMutableNotificationContent *content=[UNMutableNotificationContent new];
    content.title=@"The time has come...";
    content.body=@"Hypnotize me!";
    content.sound=[UNNotificationSound defaultSound];
    
    NSDateComponents *triggerDate=[[NSCalendar currentCalendar]components:NSCalendarUnitYear+NSCalendarUnitMonth+NSCalendarUnitDay+NSCalendarUnitHour+NSCalendarUnitMinute+NSCalendarUnitSecond fromDate:date];
    UNCalendarNotificationTrigger *trigger=[UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];
    
    NSString *identifier=@"UYLLocalNotification";
    UNNotificationRequest *request=[UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error!=nil) {
            NSLog(@"Something went wrong: %@", error);
        }
    }];
    
    /*UILocalNotification *note=[[UILocalNotification alloc]init];
    note.alertBody=@"Hypnotize me!";
    note.fireDate=date;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];*/
    
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title=@"Reminder";
        
        UIImage *i=[UIImage imageNamed:@"Time.png"];
        self.tabBarItem.image=i;
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"BNRReminderViewController loaded its view!");
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.datePicker.minimumDate=[NSDate dateWithTimeIntervalSinceNow:60];
}

@end
