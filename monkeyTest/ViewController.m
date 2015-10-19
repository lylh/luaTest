//
//  ViewController.m
//  DVSLua
//
//  Created by Quan.Shen on 1/29/15.
//  Copyright (c) 2015 Quan.Shen. All rights reserved.
//

#import "ViewController.h"
#import "CubeView.h"
#include <objc/runtime.h>
#import "LMAppController.h"
#import "commandAPI.h"

CubeView *cubeTarget;
CubeView *otherCube;

static int go_right(lua_State *L){
	CubeView *sc = (__bridge CubeView *)(lua_touserdata(L, 1));
	[sc goDirection:DirectionRight];
	return 0;
}

static int go_left(lua_State *L){
	CubeView *sc = (__bridge CubeView *)(lua_touserdata(L, 1));
	[sc goDirection:DirectionLeft];
	return 0;
}

static int go_up(lua_State *L){
	CubeView *sc = (__bridge CubeView *)(lua_touserdata(L, 1));
	[sc goDirection:DirectionUp];
	return 0;
}

static int go_down(lua_State *L){
	CubeView *sc = (__bridge CubeView *)(lua_touserdata(L, 1));
	[sc goDirection:DirectionDown];
	return 0;
}



static int get_cube_position(lua_State *L){
	CubeView *sc = (__bridge CubeView *)lua_touserdata(L, 1);
	lua_pushnumber(L, sc.center.x);
	lua_pushnumber(L, sc.center.y);
	return 2;
}

static int cubeTarget_position(lua_State *L){
	lua_pushnumber(L, cubeTarget.center.x);
	lua_pushnumber(L, cubeTarget.center.y);
	return 2;
}

static int runApp(lua_State *L){
    unsigned long size = 100;
    const char * bundid = luaL_checklstring(L, 1,&size);
    NSLog(@"bundid:%s",bundid);
    NSString *input = [[NSString alloc] initWithUTF8String:bundid];
    commandAPI *command = [[commandAPI alloc] init];
    int status = [command runApp:input];
    NSString *stringInt = [NSString stringWithFormat:@"%d",status];
    const char * status_str = [stringInt UTF8String];
    lua_pushstring(L, status_str);
    return 1;
}

static int closeApp(lua_State *L){
    unsigned long size = 100;
    const char * bundid = luaL_checklstring(L, 1,&size);
    NSLog(@"bundid:%s",bundid);
    NSString *input = [[NSString alloc] initWithUTF8String:bundid];
    commandAPI *command = [[commandAPI alloc] init];
    [command closeApp:input];
//    NSString *stringInt = [NSString stringWithFormat:@"%d",status];
//    const char * status_str = [stringInt UTF8String];
//    lua_pushstring(L, status_str);
    return 1;
}


static int mSleep(lua_State *L){
    NSLog(@"111111");
    unsigned long size = 100;
    const char * sleep = luaL_checklstring(L, 1,&size);
    NSLog(@"sleep:%s",sleep);
    NSString *num =[[NSString alloc] initWithUTF8String:sleep];
    int input = [num intValue];
    commandAPI *command = [[commandAPI alloc] init];
    [command sleep:input];
    return 1;
}

const struct luaL_Reg cubeLib[] = {
	{"go_right", go_right},
	{"go_left", go_left},
	{"go_up", go_up},
	{"go_down", go_down},
	{"get_cube_Position",get_cube_position},
	{"cubeP", cubeTarget_position},
    {"runApp", runApp},
    {"closeApp", closeApp},
    {"mSleep", mSleep},
	{NULL, NULL}
};


static  int luaopen_cubeLib (lua_State *L){
	luaL_register(L, "myLib", cubeLib);
	return 1;
}

@interface ViewController ()
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    cubeTarget = [[CubeView alloc]initWithFrame:CGRectMake(100, 200, 20, 20)
                                         Speed:10
                                          Name:@"cubeTarget"];
	
	
	[cubeTarget setBackgroundColor:[UIColor purpleColor]];
	
//	otherCube = [[CubeView alloc]initWithFrame:CGRectMake(100, 200, 20, 20)
//										 Speed:10
//										  Name:@"com.apple.mobilesafari"];
    
    
	[otherCube setBackgroundColor:[UIColor greenColor]];
	UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self
																			action:@selector(panAction:)];
	[cubeTarget addGestureRecognizer:panGesture];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(270.0, 375.0, 40.0, 20.0);
    [button setTitle:@"+" forState:UIControlStateNormal];
    //    [button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
//    [button setBackgroundImage:photo forState:UIControlStateNormal];
    [button addTarget:self action:@selector(increase:)forControlEvents:UIControlEventTouchDown];
//    [[self view] addSubview:button];
//
//    
//	
//	[self.view addSubview:otherCube];
//	[self.view addSubview:cubeTarget];
    
    
//    commandAPI *command = [[commandAPI alloc] init];
//    NSArray *pid = [command runningProcesses];
//    NSLog(@"pid:%@",pid);
//	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
//												  target:self
//												selector:@selector(runLoop:)
//												userInfo:nil
//												 repeats:YES];
    
//	[self initLuaState];
//    [self runLoop];

}


-(void)runApp:(NSString *)bundleIdentifier
{
    [[LMAppController sharedInstance] openAppWithBundleIdentifier:bundleIdentifier];
    
}

-(void)increase:(id)sender{
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"touchsprite://"]];
    [[LMAppController sharedInstance] openAppWithBundleIdentifier:@"com.apple.mobilesafari"];
}



- (void)panAction:(UIPanGestureRecognizer *)recognizer
{
	if (recognizer.state != UIGestureRecognizerStateEnded && recognizer.state != UIGestureRecognizerStateFailed){
		CGPoint location = [recognizer locationInView:recognizer.view.superview];
		recognizer.view.center = location;
	}
}


- (void)initLuaState
{
	L = luaL_newstate();
	luaL_openlibs(L);
	lua_settop(L, 0);
	luaopen_cubeLib(L);
	
	int err;
	NSString *luaFilePath = @"/var/root/Chase.lua";
    NSLog(@"luaFilePath:%@",luaFilePath);
	err = luaL_loadfile(L, [luaFilePath cStringUsingEncoding:[NSString defaultCStringEncoding]]);
    NSLog(@"err:%i",err);
	if (0 != err) {
		luaL_error(L, "compile err: %s",lua_tostring(L, -1));
		return;
	}
	
	err = lua_pcall(L, 0, 0, 0);
	if (0 != err) {
		luaL_error(L, "run err: %s",lua_tostring(L, -1));
		return;
	}
}


- (void)runLoop
{
//    [cubeTarget goDirection:DirectionDown];
    
    lua_getglobal(L, "main");
    
    int err = lua_pcall(L, 0, 0, 0);
    if (0 != err) {
        luaL_error(L, "run error: %s",
                   lua_tostring(L, -1));
        return;
    }
    
//	lua_getglobal(L, "chase");
//	lua_pushlightuserdata(L, (__bridge void *)(otherCube));
//	int err = lua_pcall(L, 1, 0, 0);
//	if (0 != err) {
//		luaL_error(L, "run error: %s",
//				   lua_tostring(L, -1));
//		return;
//	}
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
