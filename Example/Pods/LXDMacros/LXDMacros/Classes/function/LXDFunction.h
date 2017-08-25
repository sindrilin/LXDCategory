//
//  LXDFunctionn.h
//  Pods
//
//  Created by didi on 2017/8/9.
//
//

#import "LXDMacros.h"


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
