//
//  TestSuitObject.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/21.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "TestSuitObject.h"
#import "NSMutableArray+ELThreadSafe.h"

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

- (void)readObject:(NSString *)object {
    NSLog(@"%@", self.array[0]);
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

- (void)readObject:(NSString *)object {
    NSLog(@"%@", self.array[0]);
}

@end

@interface LockTestObject ()

@end

@implementation LockTestObject {
    NSRecursiveLock *_lock;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
        _lock = [[NSRecursiveLock alloc] init];
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    [_lock lock];
    [self.array addObject:object];
    [_lock unlock];
}

- (void)readObject:(NSString *)object {
    NSLog(@"%@", self.array[0]);
}

@end

@implementation SyncSelfTestObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    @synchronized (self) {
        [self.array addObject:object];
    }
}

- (void)readObject:(NSString *)object {
    NSLog(@"%@", self.array[0]);
}

@end

@implementation SerialQueueTestObject {
    dispatch_queue_t _queue;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
        _queue = dispatch_queue_create("com.queue.test.sync", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    dispatch_sync(_queue, ^{
         [self.array addObject:object];
    });
}

- (void)readObject:(NSString *)object {
    dispatch_sync(_queue, ^{
        NSLog(@"%@", self.array[0]);
    });
}

@end

@implementation ConcurrentQueueBarriarTestObject {
    dispatch_queue_t _queue;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
        _queue = dispatch_queue_create("com.queue.test.concurrent", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    dispatch_barrier_sync(_queue, ^{
        [self.array addObject:object];
    });
}

- (void)readObject:(NSString *)object {
    dispatch_sync(_queue, ^{
        NSLog(@"%@", self.array[0]);
    });
}

@end

@implementation ElTHreadSafeTestObject

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [[NSMutableArray new] _el]._threadSafeObject;
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    [self.array addObject:object];
}

- (void)readObject:(NSString *)object {
    NSLog(@"%@", self.array[0]);
}

@end

