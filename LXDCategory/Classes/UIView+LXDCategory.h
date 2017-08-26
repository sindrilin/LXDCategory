//
//  UIView+LXDLayout.h
//  Pods
//
//  Created by linxinda on 2017/8/15.
//
//

#import <UIKit/UIKit.h>


#pragma mark - frame扩展
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

@property (nonatomic, readonly) CGFloat midX;
@property (nonatomic, readonly) CGFloat midY;
@property (nonatomic, readonly) CGFloat maxX;
@property (nonatomic, readonly) CGFloat maxY;

@end


#pragma mark - xib构造器
/*!
 *  @category   UIView+LXDInitializer
 *  xib构造器
 */
@interface UIView (LXDInitializer)

/*!
 *  @method lxd_loadFromNib
 *  从<类名.xib>中寻找view
 */
+ (instancetype)lxd_loadFromNib;

/*!
 *  @method lxd_loadWithNibName:
 *  从nibName.xib中寻找view
 */
+ (instancetype)lxd_loadWithNibName: (NSString *)nibName;

@end


#pragma mark - 截图相关
/*!
 *  @category   UIView+LXDSnapshot
 *  截图相关
 */
@interface UIView (LXDSnapshot)

/*!
 *  @method lxd_snapshotImage
 *  截取view
 */
- (UIImage *)lxd_snapshotImage;

/*!
 *  @method lxd_snapshotImageInRect:
 *  截取view中rect范围的视图
 */
- (UIImage *)lxd_snapshotImageInRect: (CGRect)rect;

@end

