//
//  NSFileManager+Category.m
//  Pods
//
//  Created by linxinda on 2017/8/15.
//
//

#import "NSFileManager+LXDGenerate.h"
#import <LXDMacros/LXDMacros.h>


@implementation NSFileManager (Category)


#pragma mark Private
- (NSArray<NSData *> *)_lxdGenerateAllDatasAtPath: (NSString *)path {
    switch ([self lxd_fileTypeAtFilePath: path]) {
        case LXDFileTypeDirectory:
            return [self lxd_generateAllDatasAtDirectoryPath: path];
            
        case LXDFileTypeRegular:
        case LXDFileTypeUnkonwn:
            return @[[self contentsAtPath: path]];
            
        default:
            return @[];
    }
}

- (NSArray<NSString *> *)_lxdGenerateAllFilePathsAtPath: (NSString *)path {
    switch ([self lxd_fileTypeAtFilePath: path]) {
        case LXDFileTypeDirectory:
            return [self lxd_generateAllFilePathsAtDirectoryPath: path];
            
        case LXDFileTypeRegular:
        case LXDFileTypeUnkonwn:
            return @[path];
            
        default:
            return @[];
    }
}

- (void)_lxdEnumerateDirectoryPath: (NSString *)directoryPath withHandler: (void(^)(NSString *filePath))handler {
    if ([self lxd_fileTypeAtFilePath: directoryPath] != LXDFileTypeDirectory || handler == nil) {
        return;
    }
    
    NSDirectoryEnumerator *directoryEnumerator = [self enumeratorAtPath: directoryPath];
    NSString *filePath;
    while ((filePath = [directoryEnumerator nextObject]) != nil) {
        handler(filePath);
    }
}


#pragma mark Public
- (LXDFileType)lxd_fileTypeAtFilePath: (NSString *)filePath {
    if (![filePath isKindOfClass: [NSString class]] || [filePath length] == 0) { return LXDFileTypeInvaildFile; }
    LXDFileType fileType = LXDFileTypeUnkonwn;
    BOOL isDirectory = NO;
    if ([self fileExistsAtPath: filePath isDirectory: &isDirectory]) {
        fileType = (isDirectory ? LXDFileTypeDirectory : LXDFileTypeRegular);
    }
    return fileType;
}

- (NSArray<NSData *> *)lxd_generateAllDatasAtFilePaths: (NSArray<NSString *> *)filePaths {
    if (![filePaths isKindOfClass: [NSArray class]] || [filePaths count] == 0) { return @[]; }
    
    NSMutableArray<NSData *> *allDatas = @[].mutableCopy;
    for (NSString *filePath in filePaths) {
        [allDatas addObjectsFromArray: [self _lxdGenerateAllDatasAtPath: filePath]];
    }
    return [NSArray arrayWithArray: allDatas];
}

- (NSArray<NSData *> *)lxd_generateAllDatasAtDirectoryPath: (NSString *)directoryPath {
    if ([self lxd_fileTypeAtFilePath: directoryPath] != LXDFileTypeDirectory) { return @[]; }
    NSMutableArray<NSData *> *allDatas = @[].mutableCopy;
    
    __weak typeof(self) self_weak_ = self;
    [self _lxdEnumerateDirectoryPath: directoryPath withHandler: ^(NSString *filePath) {
        [allDatas addObjectsFromArray: [self_weak_ _lxdGenerateAllDatasAtPath: filePath]];
    }];
    
    return [NSArray arrayWithArray: allDatas];
}

- (NSArray<NSString *> *)lxd_generateAllFilePathsAtFilePaths: (NSArray<NSString *> *)filePaths {
    if (![filePaths isKindOfClass: [NSArray class]] || [filePaths count] == 0) { return @[]; }
    NSMutableArray *allFilePaths = @[].mutableCopy;
    
    for (NSString *filePath in filePaths) {
        [allFilePaths addObjectsFromArray: [self _lxdGenerateAllFilePathsAtPath: filePath]];
    }
    
    return [NSArray arrayWithArray: allFilePaths];
}

- (NSArray<NSString *> *)lxd_generateAllFilePathsAtDirectoryPath: (NSString *)directoryPath {
    if ([self lxd_fileTypeAtFilePath: directoryPath] != LXDFileTypeDirectory) { return @[]; }
    NSMutableArray *allFilePaths = @[].mutableCopy;
    
    __weak typeof(self) self_weak_ = self;
    [self _lxdEnumerateDirectoryPath: directoryPath withHandler: ^(NSString *filePath) {
        [allFilePaths addObjectsFromArray: [self_weak_ _lxdGenerateAllFilePathsAtPath: filePath]];
    }];
    
    return [NSArray arrayWithArray: allFilePaths];
}


@end
