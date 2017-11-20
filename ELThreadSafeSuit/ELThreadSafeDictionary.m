//
//  ELThreadSafeDictionary.m
//  ELThreadSafeHelper
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "ELThreadSafeDictionary.h"

@interface ELThreadSafeDictionary ()

- (void)setInnerDictionary:(NSMutableDictionary *)innerDictionary;
- (instancetype)initWithInnerDictionary:(NSMutableDictionary *)innerDictionary;

@end

@implementation ELThreadSafeDictionary {
    NSMutableDictionary *_innerDictionary;
    dispatch_queue_t _currentQueue;
}

- (BOOL)isNSDictionary__ {
    return true;
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_innerDictionary isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_innerDictionary isMemberOfClass:aClass];
}

- (BOOL)isProxy {
    return [_innerDictionary isProxy];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_innerDictionary conformsToProtocol:aProtocol];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [_innerDictionary respondsToSelector:aSelector];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@\n%@", super.description, _innerDictionary.description];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@\n%@", super.debugDescription, _innerDictionary.debugDescription];
}

- (instancetype)init {
    self = [self initWithInnerDictionary:[[NSMutableDictionary alloc] init]];
    return self;
}

- (instancetype)initWithInnerDictionary:(NSMutableDictionary *)innerDictionary {
    self = [super init];
    if (self) {
        _innerDictionary = innerDictionary;
        _currentQueue = dispatch_queue_create([[NSString stringWithFormat:@"com.qygl.array.threadsafe.queue%d", &_innerDictionary] UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)setInnerDictionary:(NSMutableDictionary *)innerDictionary {
    _innerDictionary = innerDictionary;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([self isSetterMethod:anInvocation.selector]) {
        dispatch_barrier_sync(_currentQueue, ^{
            [anInvocation invokeWithTarget:_innerDictionary];
        });
    }
    else {
        dispatch_sync(_currentQueue, ^{
            [anInvocation invokeWithTarget:_innerDictionary];
        });
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sign = [[NSMutableDictionary class] instanceMethodSignatureForSelector:aSelector];
    return sign;
}

- (BOOL)isSetterMethod:(SEL)selector {
    if (!selector) {
        return false;
    }
    NSString *selectorName = NSStringFromSelector(selector);
    if ([selectorName hasPrefix:@"add"]) {
        return true;
    }
    if ([selectorName hasPrefix:@"remove"]) {
        return true;
    }
    if ([selectorName hasPrefix:@"set"]) {
        return true;
    }
    return false;
}

- (BOOL)el_isThreadSafe {
    return true;
}

@end

@implementation NSMutableDictionary (ELThreadSafe)

- (BOOL)el_isThreadSafe {
    return false;
}

- (instancetype)normalDictionary {
    return self;
}

+ (instancetype)threadSafeDictionary {
    ELThreadSafeDictionary *dictionary = [[ELThreadSafeDictionary alloc] init];
    return (NSMutableDictionary *)dictionary;
}

+ (instancetype)threadSafeDictionaryWithCapacity:(NSUInteger)numItems {
    NSMutableDictionary *innerDictionary = [[self alloc] initWithCapacity:numItems];
    ELThreadSafeDictionary *dictionary = [[ELThreadSafeDictionary alloc] initWithInnerDictionary:innerDictionary];
    return (NSMutableDictionary *)dictionary;
}

@end

@implementation NSDictionary (ELThreadSafe)

- (NSMutableDictionary *)threadSafeMutableCopy {
    ELThreadSafeDictionary *array = [[ELThreadSafeDictionary alloc] init];
    [array setInnerDictionary:self.mutableCopy];
    return (NSMutableDictionary *)array;
}

@end
