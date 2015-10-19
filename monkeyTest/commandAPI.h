//
//  commandAPI.h
//  DVSLua
//
//  Created by lylh on 15/10/15.
//  Copyright © 2015年 Quan.Shen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commandAPI : NSObject

- (int)runApp:(NSString *)bundleIdentifier;
- (void)closeApp:(NSString *)bundleIdentifier;
- (void)sleep:(int)senconds;

//- (NSArray *)runningProcesses;
@end
