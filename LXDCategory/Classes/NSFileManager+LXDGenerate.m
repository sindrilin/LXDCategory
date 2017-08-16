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
    switch ([self lxdFileTypeAtFilePath: path]) {
        case LXDFileTypeDirectory:
            return [self lxdGenerateAllDatasAtDirectoryPath: path];
            
        case LXDFileTypeRegular:
        case LXDFileTypeUnkonwn:
            return @[[self contentsAtPath: path]];
            
        default:
            return @[];
    }
}

- (NSArray<NSString *> *)_lxdGenerateAllFilePathsAtPath: (NSString *)path {
    switch ([self lxdFileTypeAtFilePath: path]) {
        case LXDFileTypeDirectory:
            return [self lxdGenerateAllFilePathsAtDirectoryPath: path];
            
        case LXDFileTypeRegular:
        case LXDFileTypeUnkonwn:
            return @[path];
            
        default:
            return @[];
    }
}

- (void)_lxdEnumerateDirectoryPath: (NSString *)directoryPath withHandler: (void(^)(NSString *filePath))handler {
    if ([self lxdFileTypeAtFilePath: directoryPath] != LXDFileTypeDirectory || handler == nil) {
        return;
    }
    
    NSDirectoryEnumerator *directoryEnumerator = [self enumeratorAtPath: directoryPath];
    NSString *filePath;
    while ((filePath = [directoryEnumerator nextObject]) != nil) {
        handler(filePath);
    }
}


#pragma mark Public
- (LXDFileType)lxdFileTypeAtFilePath: (NSString *)filePath {
    if (![filePath isKindOfClass: [NSString class]] || [filePath length] == 0) { return LXDFileTypeInvaildFile; }
    LXDFileType fileType = LXDFileTypeUnkonwn;
    BOOL isDirectory = NO;
    if ([self fileExistsAtPath: filePath isDirectory: &isDirectory]) {
        fileType = (isDirectory ? LXDFileTypeDirectory : LXDFileTypeRegular);
    }
    return fileType;
}

- (NSArray<NSData *> *)lxdGenerateAllDatasAtFilePaths: (NSArray<NSString *> *)filePaths {
    if (![filePaths isKindOfClass: [NSArray class]] || [filePaths count] == 0) { return @[]; }
    
    NSMutableArray<NSData *> *allDatas = @[].mutableCopy;
    for (NSString *filePath in filePaths) {
        [allDatas addObjectsFromArray: [self _lxdGenerateAllDatasAtPath: filePath]];
    }
    return [NSArray arrayWithArray: allDatas];
}

- (NSArray<NSData *> *)lxdGenerateAllDatasAtDirectoryPath: (NSString *)directoryPath {
    if ([self lxdFileTypeAtFilePath: directoryPath] != LXDFileTypeDirectory) { return @[]; }
    NSMutableArray<NSData *> *allDatas = @[].mutableCopy;
    
    weakify(self);
    [self _lxdEnumerateDirectoryPath: directoryPath withHandler: ^(NSString *filePath) {
        [allDatas addObjectsFromArray: [weakself _lxdGenerateAllDatasAtPath: filePath]];
    }];
    
    return [NSArray arrayWithArray: allDatas];
}

- (NSArray<NSString *> *)lxdGenerateAllFilePathsAtFilePaths: (NSArray<NSString *> *)filePaths {
    if (![filePaths isKindOfClass: [NSArray class]] || [filePaths count] == 0) { return @[]; }
    NSMutableArray *allFilePaths = @[].mutableCopy;
    
    for (NSString *filePath in filePaths) {
        [allFilePaths addObjectsFromArray: [self _lxdGenerateAllFilePathsAtPath: filePath]];
    }
    
    return [NSArray arrayWithArray: allFilePaths];
}

- (NSArray<NSString *> *)lxdGenerateAllFilePathsAtDirectoryPath: (NSString *)directoryPath {
    if ([self lxdFileTypeAtFilePath: directoryPath] != LXDFileTypeDirectory) { return @[]; }
    NSMutableArray *allFilePaths = @[].mutableCopy;
    
    weakify(self);
    [self _lxdEnumerateDirectoryPath: directoryPath withHandler: ^(NSString *filePath) {
        [allFilePaths addObjectsFromArray: [weakself _lxdGenerateAllFilePathsAtPath: filePath]];
    }];
    
    return [NSArray arrayWithArray: allFilePaths];
}


@end
