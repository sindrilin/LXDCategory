//
//  UIButton+LXDCategory.m
//  Pods
//
//  Created by linxinda on 2017/8/25.
//
//

#import "UIButton+LXDCategory.h"


#define lxd_btn_title(state) [self titleForState: state]
#define lxd_btn_image(state) [self imageForState: state]
#define lxd_btn_title_color(state) [self titleColorForState: state]


@implementation UIButton (LXDUserInterface)


- (NSString *)normalTitle {
    return lxd_btn_title(UIControlStateNormal);
}

- (void)setNormalTitle: (NSString *)normalTitle {
    [self setTitle: normalTitle forState: UIControlStateNormal];
}

- (NSString *)selectedTitle {
    return lxd_btn_title(UIControlStateSelected);
}

- (void)setSelectedTitle: (NSString *)selectedTitle {
    [self setTitle: selectedTitle forState: UIControlStateSelected];
}

- (NSString *)disabledTitle {
    return lxd_btn_title(UIControlStateDisabled);
}

- (void)setDisabledTitle: (NSString *)disabledTitle {
    [self setTitle: disabledTitle forState: UIControlStateDisabled];
}

- (UIImage *)normalImage {
    return lxd_btn_image(UIControlStateNormal);
}

- (void)setNormalImage: (UIImage *)normalImage {
    [self setImage: normalImage forState: UIControlStateNormal];
}

- (UIImage *)selectedImage {
    return lxd_btn_image(UIControlStateSelected);
}

- (void)setSelectedImage: (UIImage *)selectedImage {
    [self setImage: selectedImage forState: UIControlStateSelected];
}

- (UIImage *)disabledImage {
    return lxd_btn_image(UIControlStateDisabled);
}

- (void)setDisabledImage: (UIImage *)disabledImage {
    [self setImage: disabledImage forState: UIControlStateDisabled];
}

- (UIColor *)normalTitleColor {
    return lxd_btn_title_color(UIControlStateNormal);
}

- (void)setNormalTitleColor: (UIColor *)normalTitleColor {
    [self setTitleColor: normalTitleColor forState: UIControlStateNormal];
}

- (UIColor *)selectedTitleColor {
    return lxd_btn_title_color(UIControlStateSelected);
}

- (void)setSelectedTitleColor: (UIColor *)selectedTitleColor {
    [self setTitleColor: selectedTitleColor forState: UIControlStateSelected];
}

- (UIColor *)disabledTitleColor {
    return lxd_btn_title_color(UIControlStateDisabled);
}

- (void)setDisabledTitleColor: (UIColor *)disabledTitleColor {
    [self setTitleColor: disabledTitleColor forState: UIControlStateDisabled];
}


@end
