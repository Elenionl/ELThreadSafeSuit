//
//  TestSuitObject.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/21.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "TestSuitObject.h"

@implementation OriginTestObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    [self.array addObject:object];
}

@end

@implementation AtomicTestObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    [self.array addObject:object];
}

@end

@interface LockTestObject ()

@property (nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation LockTestObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    [self.lock lock];
    [self.array addObject:object];
    [self.lock unlock];
}

- (NSRecursiveLock *)lock {
    static NSRecursiveLock *internalLock = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        internalLock =  [[NSRecursiveLock alloc] init];
    });
    return internalLock;
}

@end
