//
//  commandAPI.m
//  DVSLua
//
//  Created by lylh on 15/10/15.
//  Copyright © 2015年 Quan.Shen. All rights reserved.
//

#import "commandAPI.h"
#include <objc/runtime.h>
#import "LMAppController.h"
#include <stdio.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import "LMApp.h"
#import <unistd.h>


@implementation commandAPI

-(int)runApp:(NSString *)bundleIdentifier
{
    if([[LMAppController sharedInstance] openAppWithBundleIdentifier:bundleIdentifier] == YES){
        return 0;
    }
    else{
        return 1;
    }

}

-(void)closeApp:(NSString *)bundleIdentifier
{
//    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dirName = @"/tmp/ps.txt";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *err;
    if ([fileManager fileExistsAtPath:dirName]){
        NSLog(@"222");
        [fileManager removeItemAtPath:dirName error:&err];
        if (err) {
            NSLog(@"err:%@",err);
        }
        
    }
    
    const char *cmd =[[NSString stringWithFormat:@"ps -ef >> %@",dirName] UTF8String];
    system(cmd);
    
    NSArray* apps = [[LMAppController sharedInstance] installedApplications];
    for (LMApp *app in apps)
    {
        NSString *identifier = [[NSString alloc]initWithString:app.bundleIdentifier];
        if ([identifier rangeOfString:bundleIdentifier].location != NSNotFound) {
            NSString *bundlePath = [[NSString alloc]initWithString:app.bundleURL.path];
            NSString *bundleExecutable = [[NSString alloc]initWithString:app.bundleExecutable];
            NSLog(@"bundlePath :%@ \n identifier:%@ \n bundleExecutable:%@",bundlePath,identifier,bundleExecutable);
            NSString *file =[NSString stringWithContentsOfFile:dirName encoding:NSUTF8StringEncoding error:nil];
            NSArray* allLinedStrings =
            [file componentsSeparatedByCharactersInSet:
             [NSCharacterSet newlineCharacterSet]];
            
            // then break down even further
            for (int i=0; i< allLinedStrings.count; i++) {
                NSString* strsInOneLine =
                [allLinedStrings objectAtIndex:i];
                NSArray* foo = [bundlePath componentsSeparatedByString: @"/"];
                NSString* splitString =[foo objectAtIndex: foo.count-2];
                if ([strsInOneLine rangeOfString:splitString].location != NSNotFound) {
                    NSLog(@"strsInOneLine::%@",strsInOneLine);
                    NSArray* foo = [strsInOneLine componentsSeparatedByString: @" "];
                    NSString* splitSpace = [foo objectAtIndex:3];
                    const char *cmd =[[NSString stringWithFormat:@"kill -9 %@",splitSpace] UTF8String];
                    system(cmd);
                    if ([fileManager fileExistsAtPath:dirName]){
                        NSLog(@"222");
                        [fileManager removeItemAtPath:dirName error:&err];
                        if (err) {
                            NSLog(@"err:%@",err);
                        }
                        
                    }
                }
                

            }
        
        }
        
        
//        NSString *executable = app.bundleExecutable;
        
        
//        NSString *type = app.applicationType;
//        NSString *bundleContainer = app.bundleContainerURL.path;
//        NSString *dataContainer = app.dataContainerURL.path;
//        NSString *localizedName = app.localizedName;
        
        // Do cool stuff with the above
    }
    
//    NSFileManager *fm = [NSFileManager defaultManager];
//    if(![fm fileExistsAtPath:dirName])
//    {
//        if([fm createDirectoryAtPath:dirName withIntermediateDirectories:YES attributes:nil error:nil]){
//            NSLog(@"Directory Created");
//            }
//        else{
//            NSLog(@"Directory Creation Failed");}
//    }
//    else
//        NSLog(@"Directory Already Exist");
    
    
    
//    NSString* fileRoot = [[NSBundle mainBundle] pathForResource:@"/tmp/ps" ofType:@"txt"];
//    NSString *fileContents = [NSString stringWithContentsOfFile:dirName encoding:NSUTF8StringEncoding error:NULL];
//    for (NSString *line in [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]) {
//        // Do something
//        NSArray* apps = [LMAppController sharedInstance].installedApplications;
//        for(LMApp* app in apps)
//        {
//            int i = 0;
//            NSString *str = [[NSString alloc]initWithString:app.bundleIdentifier];
//            NSLog(@"appName :%@",str);
//            i = i+10;
//            
//                    }
//
//        NSLog(@"readline:%@",line);
//    }


    
    
//      [[LMAppController sharedInstance] removeInstallProgressForBundleID:bundleIdentifier];
//    if([[LMAppController sharedInstance] clearCreatedProgressForBundleID:bundleIdentifier] == YES){
//        return 0;
//    }
//    else{
//        return 1;
//    }
    
}




////返回所有正在运行的进程的 id，name，占用cpu，运行时间
////使用函数int	sysctl(int *, u_int, void *, size_t *, void *, size_t)
//- (NSArray *)runningProcesses
//{
//    //指定名字参数，按照顺序第一个元素指定本请求定向到内核的哪个子系统，第二个及其后元素依次细化指定该系统的某个部分。
//    //CTL_KERN，KERN_PROC,KERN_PROC_ALL 正在运行的所有进程
//    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL ,0};
//    
//    
//    size_t miblen = 4;
//    //值-结果参数：函数被调用时，size指向的值指定该缓冲区的大小；函数返回时，该值给出内核存放在该缓冲区中的数据量
//    //如果这个缓冲不够大，函数就返回ENOMEM错误
//    size_t size;
//    //返回0，成功；返回-1，失败
//    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
//    
//    struct kinfo_proc * process = NULL;
//    struct kinfo_proc * newprocess = NULL;
//    do
//    {
//        size += size / 10;
//        newprocess = realloc(process, size);
//        if (!newprocess)
//        {
//            if (process)
//            {
//                free(process);
//                process = NULL;
//            }
//            return nil;
//        }
//        
//        process = newprocess;
//        st = sysctl(mib, miblen, process, &size, NULL, 0);
//    } while (st == -1 && errno == ENOMEM);
//    
//    if (st == 0)
//    {
//        if (size % sizeof(struct kinfo_proc) == 0)
//        {
//            int nprocess = size / sizeof(struct kinfo_proc);
//            if (nprocess)
//            {
//                NSMutableArray * array = [[NSMutableArray alloc] init];
//                for (int i = nprocess - 1; i >= 0; i--)
//                {
//                    
//                    NSString * processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
//                    NSString * processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
//                    NSString * proc_CPU = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_estcpu];
//                    double t = [[NSDate date] timeIntervalSince1970] - process[i].kp_proc.p_un.__p_starttime.tv_sec;
//                    NSString * proc_useTiem = [[NSString alloc] initWithFormat:@"%f",t];
//                    
////                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
////                    [dic setValue:processID forKey:@"ProcessID"];
////                    [dic setValue:processName forKey:@"ProcessName"];
////                    [dic setValue:proc_CPU forKey:@"ProcessCPU"];
////                    [dic setValue:proc_useTiem forKey:@"ProcessUseTime"];
////                    
////                    [array addObject:dic];
//                    
//                    //NSLog(@"process.kp_proc.p_stat = %c",process.kp_proc.p_stat);
//                    if ([processName hasPrefix:@"MobileSafari"]) {
//                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//                        [dic setValue:processID forKey:@"ProcessID"];
//                        [dic setValue:processName forKey:@"ProcessName"];
//                        [dic setValue:proc_CPU forKey:@"ProcessCPU"];
//                        [dic setValue:proc_useTiem forKey:@"ProcessUseTime"];
//                        
//                        [array addObject:dic];
//                        const char *cmd =[[NSString stringWithFormat:@"killall -9 %@", processName] UTF8String];
////                        system(cmd);
//                    }
//                    
//                    
//                }
//                
//                free(process);
//                process = NULL;
//                NSLog(@"array = %@",array);
//                
//                return array;
//            }
//        }
//    }
//    
//    return nil;
//}

-(void)sleep:(int)senconds
{
    NSLog(@"1111");
    [NSThread sleepForTimeInterval:1.5];
    NSLog(@"2222");

}

@end
