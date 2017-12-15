//
//  NSObject+ELThreadSafe.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "NSObject+ELThreadSafe.h"
#import "ELThreadSafeObject.h"
#import <objc/runtime.h>


@implementation NSObject (ELThreadSafe)

- (BOOL)el_isThreadSafe {
    return false;
}

- (instancetype)el_normalObject {
    return self;
}

- (instancetype)el_threadSafeObject {
    ELThreadSafeObject *object = [[ELThreadSafeObject alloc] initWithInnerObject:self];
    return (NSObject *)object;
}

+ (void)setEl_threadSafeFilterActionForClass:(ELThreadSafeFilterAction)el_threadSafeFilterActionForClass {
    objc_setAssociatedObject([self class], sel_getName(@selector(setEl_threadSafeFilterActionForClass:)), el_threadSafeFilterActionForClass, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (ELThreadSafeFilterAction)el_threadSafeFilterActionForClass {
    return objc_getAssociatedObject([self class], sel_getName(@selector(setEl_threadSafeFilterActionForClass:)));
}

- (void)setEl_threadSafeFilterActionForInstance:(ELThreadSafeFilterAction)el_threadSafeFilterActionForInstance {
    objc_setAssociatedObject(self, sel_getName(@selector(setEl_threadSafeFilterActionForInstance:)), el_threadSafeFilterActionForInstance, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ELThreadSafeFilterAction)el_threadSafeFilterActionForInstance {
    return objc_getAssociatedObject(self, sel_getName(@selector(setEl_threadSafeFilterActionForInstance:)));
}

- (void)el_threadSafeAction:(ELThreadSafeSetAction)action {
    if (action) {
        action(self);
    }
}

@end
