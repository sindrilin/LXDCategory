//
//  LXDFunctionn.h
//  Pods
//
//  Created by didi on 2017/8/9.
//
//

#import "LXDMacros.h"


#pragma mark - Lock
////////////////////////////////////////////////////////////////////////////////////////////////
func_inline void __lxd_lock_block(dispatch_block_t block) {
    if (block == nil) { return; }
    static dispatch_semaphore_t __lxd_global_lock;
    static dispatch_once_t __lxd_lock_once;
    dispatch_once(&__lxd_lock_once, ^{
        __lxd_global_lock = dispatch_semaphore_create(1);
    });
    
    dispatch_semaphore_wait(__lxd_global_lock, DISPATCH_TIME_FOREVER);
    block();
    dispatch_semaphore_signal(__lxd_global_lock);
}


#pragma mark - Notification
////////////////////////////////////////////////////////////////////////////////////////////////
func_inline void __lxd_add_notification(id observer,
                                        SEL callback,
                                        NSString *notificationName) {
    [[NSNotificationCenter defaultCenter] addObserver: observer selector: callback name: notificationName object: nil];
}

func_inline void __lxd_post_notification(NSString *notificationName,
                                         id object,
                                         NSDictionary *userInfo) {
    [[NSNotificationCenter defaultCenter] postNotificationName: notificationName object: object userInfo: userInfo];
}

func_overload func_inline void __remove_notification(id observer) {
    [[NSNotificationCenter defaultCenter] removeObserver: observer];
}

func_overload func_inline void __remove_notification(id observer, NSString *notificationName) {
    [[NSNotificationCenter defaultCenter] removeObserver: observer name: notificationName object: nil];
}
