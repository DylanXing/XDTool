//
//  XDTool.h
//  XDTool
//
//  Created by 邢迪 on 16/8/10.
//  Copyright © 2016年 dylan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

/**
 *  定义枚举类型对应不同的保存根目录
 */
typedef NS_ENUM(NSInteger, SAVETYPE) {
    /**
     *  保存documents下
     */
    SAVETYPE_document = 0,
    /**
     *  cache下，数据不会备份itunes等
     */
    SAVETYPE_cache = 1,
    /**
     *  tmp，退出应用删除
     */
    SAVETYPE_tmp = 2,
};


@interface XDTool : NSObject
/**
 *  实现XDTool的单例
 */
SingletonH(XDTool)

/**
 *  获取可写路径
 *
 *  @return 可写路径，可直接将文件保存该处
 */
-(NSString *)getWriteablePath;

/**
 *  在可写目录中创建子目录并返回路径
 *
 *  @param firstSubFolder 不定长参数，依次创建多个层级目录，参数为空返回可写根目录
 *
 *  @return 可写路径，可直接将文件保存该处
 */
-(NSString *)getWriteablePathWithSubCreate:(NSString *)firstSubFolder,... NS_REQUIRES_NIL_TERMINATION;


/**
 *  在固定目录创建文件并写入内容
 *
 *  @param contentsToWrite 待写入内容，NSData *
 *  @param fileName        待创建的文件名
 *  @param savetype        保存根目录,documents(长久保存),tmp（随时会清，不安全),cache(清系统缓存时会清)
 *  @param firstSubFolder  不定长参数第一个参数，参数为nil写在根目录
 *
 *  @return 返回创建的文件路径
 */
-(NSString *)writeContents:(NSData *)contentsToWrite withFileName:(NSString *)fileName forSaveType:(SAVETYPE)savetype toFolderWithSubCreate:(NSString *)firstSubFolder,... NS_REQUIRES_NIL_TERMINATION ;


/**
 *  获取Info.plist中配置的值
 *
 *  @param plistKey Info.plist中配置的key
 *
 *  @return 可能为数组也可能为NSString,建议自定义配置为NSString
 */
-(id)getValueInPlistWithKey:(NSString *)plistKey;

@end
