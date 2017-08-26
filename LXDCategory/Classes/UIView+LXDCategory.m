//
//  UIView+LXDLayout.m
//  Pods
//
//  Created by linxinda on 2017/8/15.
//
//

#import "UIView+LXDCategory.h"


#define LXD_FRAME_SET(exp)   \
    CGRect frame = self.frame;  \
    exp;    \
    self.frame = frame


#pragma mark - frame扩展
@implementation UIView (LXDLayout)


- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX: (CGFloat)x {
    LXD_FRAME_SET(frame.origin.x = x);
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY: (CGFloat)y {
    LXD_FRAME_SET(frame.origin.y = y);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth: (CGFloat)width {
    LXD_FRAME_SET(frame.size.width = width);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight: (CGFloat)height {
    LXD_FRAME_SET(frame.size.height = height);
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize :(CGSize)size {
    LXD_FRAME_SET(frame.size = size);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin: (CGPoint)origin {
    LXD_FRAME_SET(frame.origin = origin);
}

- (CGFloat)midX {
    return CGRectGetMidX(self.frame);
}

- (CGFloat)midY {
    return CGRectGetMidY(self.frame);
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}


@end



#pragma mark - xib构造器
@implementation UIView (LXDInitializer)


+ (instancetype)loadFromNib {
    return [self loadWithNibName: NSStringFromClass([self class])];
}

+ (instancetype)loadWithNibName: (NSString *)nibName {
    if (![nibName isKindOfClass: [NSString class]] || [nibName length] == 0) { return nil; }
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed: nibName owner: nil options: nil];
    for (id nib in nibs) {
        if ([nib isKindOfClass: [self class]]) {
            return nib;
        }
    }
    return nil;
}


@end



#pragma mark -  截图相关
@implementation UIView (LXDSnapshot)


- (UIImage *)lxd_snapshotImage {
    return [self lxd_snapshotImageInRect: self.bounds];
}

- (UIImage *)lxd_snapshotImageInRect: (CGRect)rect {
    if (CGRectGetMaxX(rect) > self.width) {
        rect.size.width = self.width - rect.origin.x;
    }
    if (CGRectGetMaxY(rect) > self.height) {
        rect.size.height = self.height - rect.origin.y;
    }
    if (CGRectGetHeight(rect) < 0 || CGRectGetWidth(rect) < 0) { return nil; }
    
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    UIRectClip(rect);
    
    [self.layer renderInContext: ctx];
    UIImage * snapImage = UIGraphicsGetImageFromCurrentImageContext();
    CGContextRestoreGState(ctx);
    UIGraphicsEndImageContext();
    return snapImage;
}


@end


