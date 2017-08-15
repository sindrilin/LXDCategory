//
//  UIView+LXDLayout.h
//  Pods
//
//  Created by linxinda on 2017/8/15.
//
//

#import <UIKit/UIKit.h>

/*!
 *  @category   UIView+LXDLayout
 *  扩展frame相关属性
 */
@interface UIView (LXDLayout)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@end


/*!
 *  @category   UIView+LXDInitializer
 */
@interface UIView (LXDInitializer)

+ (instancetype)loadFromNib;
+ (instancetype)loadWithNibName: (NSString *)nibName;

@end
