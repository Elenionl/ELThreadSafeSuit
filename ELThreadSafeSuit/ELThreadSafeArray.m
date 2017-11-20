//
//  ELThreadSafeArray.m
//  UnitTest
//
//  Created by Elenion on 2017/10/16.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "ELThreadSafeArray.h"

@interface ELThreadSafeArray ()

- (void)setInnerArray:(NSMutableArray *)innerArray;
- (instancetype)initWithInnerArray:(NSMutableArray *)innerArray;

@end

@implementation ELThreadSafeArray {
    NSMutableArray *_innerArray;
    dispatch_queue_t _currentQueue;
}

- (BOOL)isNSArray__ {
    return true;
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_innerArray isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_innerArray isMemberOfClass:aClass];
}

- (BOOL)isProxy {
    return [_innerArray isProxy];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_innerArray conformsToProtocol:aProtocol];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [_innerArray respondsToSelector:aSelector];
}

- (IMP)methodForSelector:(SEL)aSelector {
    if ([self methodForSelector:aSelector]) {
        return [self methodForSelector:aSelector];
    }
    return [_innerArray methodForSelector:aSelector];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@\n%@", super.description, _innerArray.description];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@\n%@", super.debugDescription, _innerArray.debugDescription];
}

- (instancetype)init {
    self = [self initWithInnerArray:[[NSMutableArray alloc] init]];
    return self;
}

- (instancetype)initWithInnerArray:(NSMutableArray *)innerArray {
    self = [super init];
    if (self) {
        _innerArray = innerArray;
        _currentQueue = dispatch_queue_create([[NSString stringWithFormat:@"com.qygl.array.threadsafe.queue%d", &_innerArray] UTF8String], DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)setInnerArray:(NSMutableArray *)innerArray {
    _innerArray = innerArray;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([self isSetterMethod:anInvocation.selector]) {
        dispatch_barrier_sync(_currentQueue, ^{
            [anInvocation invokeWithTarget:_innerArray];
        });
    }
    else {
        dispatch_sync(_currentQueue, ^{
            [anInvocation invokeWithTarget:_innerArray];
        });
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sign = [[NSMutableArray class] instanceMethodSignatureForSelector:aSelector];
    return sign;
}

- (BOOL)isSetterMethod:(SEL)selector {
    if (!selector) {
        return false;
    }
    NSString *selectorName = NSStringFromSelector(selector);
    if ([selectorName containsString:@"Observer"]) {
        return false;
    }
    if ([selectorName hasPrefix:@"add"]) {
        return true;
    }
    if ([selectorName hasPrefix:@"insert"]) {
        return true;
    }
    if ([selectorName hasPrefix:@"remove"]) {
        return true;
    }
    if ([selectorName hasPrefix:@"set"]) {
        return true;
    }
    if ([selectorName hasPrefix:@"replace"]) {
        return true;
    }
    if ([selectorName hasPrefix:@"exchange"]) {
        return true;
    }
    if ([selectorName hasPrefix:@"sort"] && ![selectorName hasPrefix:@"sorted"]) {
        return true;
    }
    if ([selectorName hasPrefix:@"filter"] && ![selectorName hasPrefix:@"filtered"]) {
        return true;
    }
    return false;
}

- (BOOL)el_isThreadSafe {
    return true;
}

@end

@implementation NSMutableArray (ELThreadSafe)

- (BOOL)el_isThreadSafe {
    return false;
}

- (instancetype)normalArray {
    return self;
}

+ (instancetype)threadSafeArray {
    ELThreadSafeArray *array = [[ELThreadSafeArray alloc] init];
    return (NSMutableArray *)array;
}

+ (instancetype)threadSafeArrayWithCapacity:(NSUInteger)numItems {
    NSMutableArray *innerArray = [[self alloc] initWithCapacity:numItems];
    ELThreadSafeArray *array = [[ELThreadSafeArray alloc] initWithInnerArray:innerArray];
    return (NSMutableArray *)array;
}

@end

@implementation NSArray (ELThreadSafe)

- (NSMutableArray *)threadSafeMutableCopy {
    ELThreadSafeArray *array = [[ELThreadSafeArray alloc] init];
    [array setInnerArray:self.mutableCopy];
    return (NSMutableArray *)array;
}

@end
