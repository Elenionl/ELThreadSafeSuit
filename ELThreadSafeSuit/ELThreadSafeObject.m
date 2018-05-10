//
//  ELThreadSafeObject.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

typedef id(^ELAutoSelectorAction)(id _self, id sender, ...);

#import "ELThreadSafeObject.h"
#import "NSObject+ELThreadSafe.h"
#import "NSObject-_NSIsKinds.h"

@interface ELThreadSafeObject ()

@end

@implementation ELThreadSafeObject {
    id _innerObject;
    dispatch_queue_t _currentQueue;
    NSString *_identifier;
}

#pragma mark - OverrideNSObjectMethods

- (NSString *)description {
    return [NSString stringWithFormat:@"%@\n_innerObject:%@", super.description, [_innerObject description]];
}

#pragma mark - LifeCircle

- (instancetype)initWithInnerObject:(id)innerObject {
    if (self) {
        _innerObject = innerObject;
        _identifier = [NSString stringWithFormat:@"com.elgl.threadsafe.%@", [self description]];
         CFStringRef identifierRef = (__bridge CFStringRef)_identifier;
        _currentQueue = dispatch_queue_create([_identifier UTF8String], DISPATCH_QUEUE_CONCURRENT);
        dispatch_queue_set_specific(_currentQueue, &_identifier, (void *)identifierRef, NULL);
    }
    return self;
}

#pragma mark - Forward

- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    CFStringRef identifierRef = dispatch_get_specific(&_identifier);
//    if ([_identifier isEqualToString:((__bridge NSString *)identifierRef)]) {
//        [anInvocation invokeWithTarget:_innerObject];
//    }
//    else
        if ([self isSelectorNeedProtect:anInvocation.selector]) {
        dispatch_barrier_sync(_currentQueue, ^{
            [anInvocation invokeWithTarget:self.innerObject];
        });
    }
    else {
        dispatch_sync(_currentQueue, ^{
            [anInvocation invokeWithTarget:self.innerObject];
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

- (void)el_threadSafeAction:(ELThreadSafeSetAction)action {
    if (action) {
        dispatch_barrier_sync(_currentQueue, ^{
            action(self.innerObject);
        });
    }
}

@end
