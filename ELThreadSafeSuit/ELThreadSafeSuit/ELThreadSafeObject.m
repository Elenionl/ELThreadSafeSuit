//
//  ELThreadSafeObject.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "ELThreadSafeObject.h"
#import "NSObject+ELThreadSafe.h"
#import "NSObject-_NSIsKinds.h"

@interface ELThreadSafeObject ()

@end

@implementation ELThreadSafeObject {
    id _innerObject;
    dispatch_queue_t _currentQueue;
}

#pragma mark - OverrideNSObjectMethods

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

#pragma mark - LifeCircle

- (instancetype)initWithInnerObject:(id)innerObject {
    self = [super init];
    if (self) {
        _innerObject = innerObject;
        _currentQueue = dispatch_queue_create([[NSString stringWithFormat:@"com.qygl.array.threadsafe.queue%d", &_innerObject] UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

#pragma mark - Forward

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

#pragma mark - Getter/Setter

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

#pragma mark - NSIsKinds

- (BOOL)isNSValue__ {
    if ([_innerObject respondsToSelector:@selector(isNSValue__)]) {
        return [_innerObject isNSValue__];
    }
    return false;
}

- (BOOL)isNSTimeZone__ {
    if ([_innerObject respondsToSelector:@selector(isNSTimeZone__)]) {
        return [_innerObject isNSTimeZone__];
    }
    return false;
}

- (BOOL)isNSString__ {
    if ([_innerObject respondsToSelector:@selector(isNSString__)]) {
        return [_innerObject isNSString__];
    }
    return false;
}

- (BOOL)isNSSet__ {
    if ([_innerObject respondsToSelector:@selector(isNSSet__)]) {
        return [_innerObject isNSSet__];
    }
    return false;
}

- (BOOL)isNSOrderedSet__ {
    if ([_innerObject respondsToSelector:@selector(isNSOrderedSet__)]) {
        return [_innerObject isNSOrderedSet__];
    }
    return false;
}

- (BOOL)isNSNumber__ {
    if ([_innerObject respondsToSelector:@selector(isNSNumber__)]) {
        return [_innerObject isNSNumber__];
    }
    return false;
}

- (BOOL)isNSDictionary__ {
    if ([_innerObject respondsToSelector:@selector(isNSDictionary__)]) {
        return [_innerObject isNSDictionary__];
    }
    return false;
}

- (BOOL)isNSDate__ {
    if ([_innerObject respondsToSelector:@selector(isNSDate__)]) {
        return [_innerObject isNSDate__];
    }
    return false;
}

-(BOOL)isNSData__ {
    if ([_innerObject respondsToSelector:@selector(isNSData__)]) {
        return [_innerObject isNSData__];
    }
    return false;
}

- (BOOL)isNSArray__ {
    if ([_innerObject respondsToSelector:@selector(isNSArray__)]) {
        return [_innerObject isNSArray__];
    }
    return false;
}

@end