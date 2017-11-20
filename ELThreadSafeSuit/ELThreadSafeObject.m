//
//  ELThreadSafeObject.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "ELThreadSafeObject.h"
#import "NSObject+ELThreadSafe.h"

@interface ELThreadSafeObject ()

@end

@implementation ELThreadSafeObject {
    id _innerObject;
    dispatch_queue_t _currentQueue;
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_innerObject isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_innerObject isMemberOfClass:aClass];
}

- (BOOL)isProxy {
    return [_innerObject isProxy];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_innerObject conformsToProtocol:aProtocol];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [_innerObject respondsToSelector:aSelector];
}

- (IMP)methodForSelector:(SEL)aSelector {
    if ([self methodForSelector:aSelector]) {
        return [self methodForSelector:aSelector];
    }
    return [_innerObject methodForSelector:aSelector];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@\n%@", super.description, [_innerObject description]];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@\n%@", super.debugDescription, [_innerObject debugDescription]];
}

- (instancetype)initWithInnerObject:(id)innerObject {
    self = [super init];
    if (self) {
        _innerObject = innerObject;
        _currentQueue = dispatch_queue_create([[NSString stringWithFormat:@"com.qygl.array.threadsafe.queue%d", &_innerObject] UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([self isSelectorNeedProtect:anInvocation.selector]) {
        dispatch_barrier_sync(_currentQueue, ^{
            [anInvocation invokeWithTarget:_innerObject];
        });
    }
    else {
        dispatch_sync(_currentQueue, ^{
            [anInvocation invokeWithTarget:_innerObject];
        });
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sign = [[_innerObject class] instanceMethodSignatureForSelector:aSelector];
    return sign;
}



- (BOOL)isSelectorNeedProtect:(SEL)selector {
    if ([_innerObject el_threadSafeFilterActionForInstance]) {
        return [_innerObject el_threadSafeFilterActionForInstance](selector);
    }
    if ([[_innerObject class] el_threadSafeFilterActionForClass]) {
        return [[_innerObject class] el_threadSafeFilterActionForClass](selector);
    }
    return false;
}

- (BOOL)el_isThreadSafe {
    return true;
}

- (instancetype)el_threadSafeObject {
    return self;
}

- (NSObject *)innerObject {
    return _innerObject;
}

- (void)setInnerObject:(NSObject *)innerObject {
    _innerObject = innerObject;
}

@end
