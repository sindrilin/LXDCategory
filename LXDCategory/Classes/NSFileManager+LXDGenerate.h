//
//  NSFileManager+Category.h
//  Pods
//
//  Created by linxinda on 2017/8/15.
//
//


#import <Foundation/Foundation.h>
#import <LXDMacros/LXDMacros.h>


nonull_begin

typedef NS_ENUM(NSInteger, LXDFileType)
{
    LXDFileTypeRegular,
    LXDFileTypeDirectory,
    LXDFileTypeUnkonwn,
    LXDFileTypeInvaildFile,
};

/*!
 *  @category   NSFileManager+LXDGenerate
 *  文件目录相关获取
 */
@interface NSFileManager (LXDGenerate)

/*!
 *  @method   lxd_fileTypeAtFilePath:
 *  获取文件类型
 */
- (LXDFileType)lxd_fileTypeAtFilePath: (NSString *)filePath;

/*!
 *  @method   lxd_generateAllDatasAtDirectoryPath:
 *  获取目录下所有的非文件夹文件数据
 */
- (NSArray<NSData *> *)lxd_generateAllDatasAtDirectoryPath: (NSString *)directoryPath;

/*!
 *  @method   lxd_generateAllDatasAtFilePaths:
 *  获取多个目录下所有的非文件夹文件数据
 */
- (NSArray<NSData *> *)lxd_generateAllDatasAtFilePaths: (NSArray<NSString *> *)filePaths;

/*!
 *  @method   lxd_generateAllFilePathsAtDirectoryPath:
 *  获取目录下所有的非文件夹文件目录
 */
- (NSArray<NSString *> *)lxd_generateAllFilePathsAtDirectoryPath: (NSString *)directoryPath;

/*!
 *  @method   lxd_generateAllFilePathsAtFilePaths:
 *  获取多个目录下所有的非文件夹文件目录
 */
- (NSArray<NSString *> *)lxd_generateAllFilePathsAtFilePaths: (NSArray<NSString *> *)filePaths;

@end


nonnull_end

