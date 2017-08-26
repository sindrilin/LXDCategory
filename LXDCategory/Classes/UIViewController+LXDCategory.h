//
//  UIViewController+LXDCategory.h
//  Pods
//
//  Created by linxinda on 2017/8/26.
//
//

#import <UIKit/UIKit.h>



/*!
 *  @category   UIViewController+LXDTransition
 *  转场相关
 */
@interface UIViewController (LXDInitialize)

/*!
 *  @method lxd_loadFromNib
 *  根据控制器名字从对应xib中加载控制器
 */
+ (instancetype)lxd_loadFromNib;

/*!
 *  @method lxd_loadFromNibWithName:
 *  根据传入的xib名字初始化控制器
 */
+ (instancetype)lxd_loadFromNibWithName: (NSString *)nibName;

/*!
 *  @method lxd_loadFromNibWithName:bundle:
 *  根据传入的xib名字和对应的bundle初始化控制器
 */
+ (instancetype)lxd_loadFromNibWithName: (NSString *)nibName bundle: (NSBundle *)bundle;

@end



/*!
 *  @category   UIViewController+LXDTransition
 *  转场相关
 */
@interface UIViewController (LXDTransition)

/*!
 *  @method lxd_pushViewController:fromIndex:
 *  进行push跳转，跳转完成之后自动将返回控制器设置从index开始
 *  如果不能进行push，那么按照present方式跳转，且index无意义
 */
- (void)lxd_pushViewController: (UIViewController *)viewController
                     fromIndex: (NSInteger)index;

/*!
 *  @method lxd_pushViewController:fromIndex:animated:complete:
 *  进行push跳转，跳转完成之后自动将返回控制器设置从index开始。可以设置是否有动画以及跳转完成回调
 *  如果不能进行push，那么按照present方式跳转，且index无意义
 */
- (void)lxd_pushViewController: (UIViewController *)viewController
                     fromIndex: (NSInteger)index
                      animated: (BOOL)animated
                      complete: (dispatch_block_t)complete;

/*!
 *  @method lxd_pushViewController:fromViewController:
 *  进行push跳转，跳转完成之后自动将返回控制器设置从fromViewController开始
 *  如果不能进行push，那么按照present方式跳转，且index无意义
 */
- (void)lxd_pushViewController: (UIViewController *)viewController
            fromViewController: (UIViewController *)fromViewController;

/*!
 *  @method lxd_pushViewController:fromViewController:animated:complete:
 *  进行push跳转，跳转完成之后自动将返回控制器设置从fromViewController开始。允许设置动画和回调
 *  如果不能进行push，那么按照present方式跳转，且index无意义
 */
- (void)lxd_pushViewController: (UIViewController *)viewController
            fromViewController: (UIViewController *)fromViewController
                      animated: (BOOL)animated
                      complete: (dispatch_block_t)complete;

@end
