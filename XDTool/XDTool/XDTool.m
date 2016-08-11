//
//  XDTool.m
//  XDTool
//
//  Created by 邢迪 on 16/8/10.
//  Copyright © 2016年 dylan. All rights reserved.
//

#import "XDTool.h"

@implementation XDTool
SingletonM(XDTool)

-(NSString *)getWriteablePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

-(NSString *)getWriteablePathWithSubCreate:(NSString *)firstSubFolder,...{
    va_list ap;
    
    // 定位不定形参列表（省略号部分）之前的一个形参
    va_start(ap, firstSubFolder);
    
    NSMutableArray<NSString*> *subFolderArray = [NSMutableArray arrayWithCapacity:10];
    // 如果firstSubFolder参数本身为空，则不去解析不定形参部分
    if(firstSubFolder != nil)
    {
        [subFolderArray addObject:firstSubFolder];
        
        // 这里假定：如果firstSubFolder不为空，则后续一定跟着至少一个不定实参
        NSString *subName;
        
        // 开始迭代
        do
        {
            subName = va_arg(ap, NSString*);
            if(subName != nil)
                [subFolderArray addObject:subName];
        }
        while(subName != nil);
    }
    
    // 迭代结束
    va_end(ap);
    
    NSString *resultPath =  [self getWriteablePath];
    for (NSString *subFolder in subFolderArray) {
        resultPath = [resultPath stringByAppendingPathComponent:subFolder];
    }
    [[NSFileManager defaultManager]createDirectoryAtPath:resultPath withIntermediateDirectories:YES attributes:nil error:nil];
    return resultPath;
}

-(NSString *)writeContents:(NSData *)contentsToWrite withFileName:(NSString *)fileName forSaveType:(SAVETYPE)savetype toFolderWithSubCreate:(NSString *)firstSubFolder,...{
    va_list ap;
    
    // 定位不定形参列表（省略号部分）之前的一个形参
    va_start(ap, firstSubFolder);
    
    NSMutableArray<NSString*> *subFolderArray = [NSMutableArray arrayWithCapacity:10];
    // 如果firstSubFolder参数本身为空，则不去解析不定形参部分
    if(firstSubFolder != nil)
    {
        [subFolderArray addObject:firstSubFolder];
        
        // 这里假定：如果firstSubFolder不为空，则后续一定跟着至少一个不定实参
        NSString *subName;
        
        // 开始迭代
        do
        {
            subName = va_arg(ap, NSString*);
            if(subName != nil)
                [subFolderArray addObject:subName];
        }
        while(subName != nil);
    }
    
    // 迭代结束
    va_end(ap);
    NSString *resultPath;
    switch (savetype) {
        case SAVETYPE_document:
            resultPath =  [self getWriteablePath];
            break;
        case SAVETYPE_tmp:
            resultPath = NSTemporaryDirectory();
            break;
        case SAVETYPE_cache:
        {
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            resultPath = [paths objectAtIndex:0];//获取缓存目录
        }
            break;
        default:
            resultPath =  [self getWriteablePath];
            break;
    }
    
    for (NSString *subFolder in subFolderArray) {
        resultPath = [resultPath stringByAppendingPathComponent:subFolder];
    }
    [[NSFileManager defaultManager]createDirectoryAtPath:resultPath withIntermediateDirectories:YES attributes:nil error:nil];
    //以上创建了文件夹，下面创建文件
    resultPath = [resultPath stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager]createFileAtPath:resultPath contents:contentsToWrite attributes:nil];
    return resultPath;
}

-(id)getValueInPlistWithKey:(NSString *)plistKey{
    return NULL;
}
@end
