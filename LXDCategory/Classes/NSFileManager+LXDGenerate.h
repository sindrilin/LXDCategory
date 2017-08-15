//
//  NSFileManager+Category.h
//  Pods
//
//  Created by linxinda on 2017/8/15.
//
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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
 *  @method   lxdFileTypeAtFilePath:
 *  获取文件类型
 */
- (LXDFileType)lxdFileTypeAtFilePath: (NSString *)filePath;

/*!
 *  @method   lxdGenerateAllDatasAtDirectoryPath:
 *  获取目录下所有的非文件夹文件数据
 */
- (NSArray<NSData *> *)lxdGenerateAllDatasAtDirectoryPath: (NSString *)directoryPath;

/*!
 *  @method   lxdGenerateAllDatasAtFilePaths:
 *  获取多个目录下所有的非文件夹文件数据
 */
- (NSArray<NSData *> *)lxdGenerateAllDatasAtFilePaths: (NSArray<NSString *> *)filePaths;

/*!
 *  @method   lxdGenerateAllFilePathsAtDirectoryPath:
 *  获取目录下所有的非文件夹文件目录
 */
- (NSArray<NSString *> *)lxdGenerateAllFilePathsAtDirectoryPath: (NSString *)directoryPath;

/*!
 *  @method   lxdGenerateAllFilePathsAtFilePaths:
 *  获取多个目录下所有的非文件夹文件目录
 */
- (NSArray<NSString *> *)lxdGenerateAllFilePathsAtFilePaths: (NSArray<NSString *> *)filePaths;

@end


NS_ASSUME_NONNULL_END

