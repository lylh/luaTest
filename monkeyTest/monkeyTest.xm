#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <objc/runtime.h>
#import <LMAppController.h>
#import "ViewController.h"
#import "LMApp.h"

static UIButton *btn;
static UIButton *button;
//NSString *bundleIdentifier = @"com.touchsprite.ios";
//NSData *photo_data = [NSData dataWithContentsOfFile:@"/var/mobile/Library/SpringBoard/iconForward_green@2x.png"];
//UIImage *photo = [UIImage imageWithData: photo_data];



@interface SBApplicationIcon : NSObject

- (NSString*)displayName;

@end


%hook VolumeControl
-(void)volumeStepUp
{
    NSLog(@"[++++]into volumeChanged----------");

}

-(void)volumeStepDown
{
    NSLog(@"[------]into volumeChanged----------");
    ViewController *controller = [[ViewController alloc] init];
    [controller initLuaState];
    [controller runLoop];
    
}

//- (void)_volumeChanged:(id)changed
//{
//    NSLog(@"[++++]into volumeChanged----------");
////    ViewController *controller = [[ViewController alloc] init];
////    [controller initLuaState];
////    [controller runLoop];
////    %orig;
//}

%end


//%hook SpringBoard
//- (_Bool)_volumeChanged:(struct __IOHIDEvent *)arg1
//{
//    NSLog(@"[++++]into volumeChanged,By PiaoYun WwW.CHiNAPYG.CoM----------");
//        // 这里替换成你的猥琐代码，行动吧少年.....
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test"
//                                                    message:@"Welcome to test iPhone!"
//                                                   delegate:nil
//                                          cancelButtonTitle:@"Thanks"
//                                          otherButtonTitles:nil];
//    [alert show];
//    [alert release];
//    %orig;
//}


//-(void)applicationDidFinishLaunching:(id)application
//{
//
//%orig;
//    
//    
//    
////
////    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test"
////    message:@"Welcome to test iPhone!"
////    delegate:nil
////    cancelButtonTitle:@"Thanks"
////    otherButtonTitles:nil];
////    [alert show];
////    [alert release];
////    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"touchsprite://"]];
////Class LSApplicationWorkspace = NSClassFromString(@"LSApplicationWorkspace");
////id si = [LSApplicationWorkspace valueForKey:@"defaultWorkspace"];
////SEL selector=NSSelectorFromString(@"openApplicationWithBundleID:");
////BOOL what=[[si performSelector:selector withObject:@"com.ucweb.ucbrowser.iphone.international"] boolValue];
//    
//
//}
//- (void)volumeChanged:(NSNotification *)notification
//{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test"
//                                                    message:@"Welcome to test iPhone!"
//                                                   delegate:nil
//                                          cancelButtonTitle:@"Thanks"
//                                          otherButtonTitles:nil];
//    [alert show];
//    [alert release];
//    
//    
////    float volume =
////    [[[notification userInfo]
////      objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"]
////     floatValue];
////    
////    DDLogVerbose(@"current volume = %f", volume);
//}
//

//%end

//%hook SBUIController
//-(void)finishLaunching{
////    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
////    btn.frame = CGRectMake(20.0, 375.0, 40.0, 20.0);
////    [btn setTitle:@"-" forState:UIControlStateNormal];
////    [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
////    [btn setBackgroundImage:image forState:UIControlStateNormal];
////    [btn addTarget:self action:@selector(decrease:)forControlEvents:UIControlEventTouchDown];
////    [[self window] addSubview:btn];
//    
//    
//   
////    NSString *bundleIdentifier = @"ttt";
////    NSArray* apps = [LMAppController sharedInstance].installedApplications;
////    for(LMApp* app in apps)
////    {
////        NSString *str = [[NSString alloc]initWithString:app.bundleIdentifier];
////        
////        
////        if([bundleIdentifier isEqualToString:str]){
////            NSLog(@"appName :%@",app.bundleIdentifier);
////            button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
////            button.frame = CGRectMake(270.0, 375.0, 40.0, 20.0);
////            //    [button setTitle:@"+" forState:UIControlStateNormal];
////            //    [button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
////            [button setBackgroundImage:photo forState:UIControlStateNormal];
////            [button addTarget:self action:@selector(increase:)forControlEvents:UIControlEventTouchDown];
////            [[self window] addSubview:button];
////
////        }
////        
////    }
//    
//    
//    
//}
////%new(v@:@@)
////
////-(void)increase:(id)sender{
//////    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"touchsprite://"]];
////    [[LMAppController sharedInstance] openAppWithBundleIdentifier:bundleIdentifier];
////}
//
//%end



//%hook SBApplicationIcon
//
//-(void)launchFromLocation:(int)location
//{
//    NSLog(@"lanch From location");
//    ViewController *controller = [[ViewController alloc] init];
//    [controller initLuaState];
//    [controller runLoop];
//
//%orig;
//}
//
//
//%end


