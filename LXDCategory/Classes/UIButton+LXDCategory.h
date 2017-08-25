//
//  UIButton+LXDCategory.h
//  Pods
//
//  Created by linxinda on 2017/8/25.
//
//

#import <UIKit/UIKit.h>

/*!
 *  @category   UIButton+LXDUserInterface
 *  UI设置
 */
@interface UIButton (LXDUserInterface)

@property (nonatomic, readwrite) NSString *normalTitle;
@property (nonatomic, readwrite) NSString *selectedTitle;
@property (nonatomic, readwrite) NSString *disabledTitle;
@property (nonatomic, readwrite) UIImage *normalImage;
@property (nonatomic, readwrite) UIImage *selectedImage;
@property (nonatomic, readwrite) UIImage *disabledImage;
@property (nonatomic, readwrite) UIColor *normalTitleColor;
@property (nonatomic, readwrite) UIColor *selectedTitleColor;
@property (nonatomic, readwrite) UIColor *disabledTitleColor;

@end
