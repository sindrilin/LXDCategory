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


@end



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


