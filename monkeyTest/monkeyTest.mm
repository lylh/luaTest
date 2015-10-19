#line 1 "/Users/lylh/Documents/macsoft/monkeyTest/monkeyTest/monkeyTest.xm"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <objc/runtime.h>
#import <LMAppController.h>
#import "ViewController.h"
#import "LMApp.h"

static UIButton *btn;
static UIButton *button;






@interface SBApplicationIcon : NSObject

- (NSString*)displayName;

@end


#include <logos/logos.h>
#include <substrate.h>
@class VolumeControl; 
static void (*_logos_orig$_ungrouped$VolumeControl$volumeStepUp)(VolumeControl*, SEL); static void _logos_method$_ungrouped$VolumeControl$volumeStepUp(VolumeControl*, SEL); static void (*_logos_orig$_ungrouped$VolumeControl$volumeStepDown)(VolumeControl*, SEL); static void _logos_method$_ungrouped$VolumeControl$volumeStepDown(VolumeControl*, SEL); 

#line 23 "/Users/lylh/Documents/macsoft/monkeyTest/monkeyTest/monkeyTest.xm"


static void _logos_method$_ungrouped$VolumeControl$volumeStepUp(VolumeControl* self, SEL _cmd) {
    NSLog(@"[++++]into volumeChanged----------");

}


static void _logos_method$_ungrouped$VolumeControl$volumeStepDown(VolumeControl* self, SEL _cmd) {
    NSLog(@"[------]into volumeChanged----------");
    ViewController *controller = [[ViewController alloc] init];
    [controller initLuaState];
    [controller runLoop];
    
}









































































































































static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$VolumeControl = objc_getClass("VolumeControl"); MSHookMessageEx(_logos_class$_ungrouped$VolumeControl, @selector(volumeStepUp), (IMP)&_logos_method$_ungrouped$VolumeControl$volumeStepUp, (IMP*)&_logos_orig$_ungrouped$VolumeControl$volumeStepUp);MSHookMessageEx(_logos_class$_ungrouped$VolumeControl, @selector(volumeStepDown), (IMP)&_logos_method$_ungrouped$VolumeControl$volumeStepDown, (IMP*)&_logos_orig$_ungrouped$VolumeControl$volumeStepDown);} }
#line 175 "/Users/lylh/Documents/macsoft/monkeyTest/monkeyTest/monkeyTest.xm"
