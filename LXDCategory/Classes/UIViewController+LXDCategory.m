//
//  UIViewController+LXDCategory.m
//  Pods
//
//  Created by linxinda on 2017/8/26.
//
//

#import "UIViewController+LXDCategory.h"



@implementation UIViewController (LXDInitialize)


+ (instancetype)lxd_loadFromNib {
    return [self lxd_loadFromNibWithName: NSStringFromClass([self class]) bundle: [NSBundle mainBundle]];
}

+ (instancetype)lxd_loadFromNibWithName: (NSString *)nibName {
    return [self lxd_loadFromNibWithName: nibName bundle: [NSBundle mainBundle]];
}

+ (instancetype)lxd_loadFromNibWithName: (NSString *)nibName bundle: (NSBundle *)bundle {
    return [[self alloc] initWithNibName: nibName bundle: bundle];
}


@end


@implementation UIViewController (LXDTransition)


- (void)lxd_pushViewController: (UIViewController *)viewController fromIndex: (NSInteger)index {
    [self lxd_pushViewController: viewController fromIndex: index animated: YES complete: nil];
}

- (void)lxd_pushViewController: (UIViewController *)viewController fromIndex: (NSInteger)index animated: (BOOL)animated complete: (dispatch_block_t)complete {
    if (self.navigationController) {
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray: self.navigationController.viewControllers];
        BOOL needPopControllers = (index < viewControllers.count - 1);
        if (needPopControllers) {
            NSIndexSet *set = [[NSIndexSet alloc] initWithIndexesInRange: NSMakeRange(index + 1, viewControllers.count - index - 1)];
            [viewControllers removeObjectsAtIndexes: set];
            [viewControllers addObject: viewController];
            
            [CATransaction begin];
            [CATransaction setCompletionBlock: ^{
                [self.navigationController setViewControllers: viewControllers animated: NO];
                if (complete) { complete(); }
            }];
            
            [CATransaction commit];
        } else {
            [self.navigationController pushViewController: viewController animated: animated];
        }
    } else {
        [self presentViewController: viewController animated: animated completion: complete];
    }
}

- (void)lxd_pushViewController: (UIViewController *)viewController fromViewController: (UIViewController *)fromViewController {
    [self lxd_pushViewController: viewController fromViewController: fromViewController animated: YES complete: nil];
}

- (void)lxd_pushViewController: (UIViewController *)viewController fromViewController: (UIViewController *)fromViewController animated: (BOOL)animated complete: (dispatch_block_t)complete {
    if (self.navigationController) {
        for (NSInteger idx = 0; idx < self.navigationController.viewControllers.count; idx++) {
            if (self.navigationController.viewControllers[idx] == fromViewController) {
                [self lxd_pushViewController: viewController fromIndex: idx animated: animated complete: complete];
                return;
            }
        }
        [self.navigationController pushViewController: viewController animated: animated];
    } else {
        [self presentViewController: viewController animated: animated completion: complete];
    }
}


@end
