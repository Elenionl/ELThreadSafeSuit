//
//  TestSuitObject.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/21.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "TestSuitObject.h"
#import "NSMutableArray+ELThreadSafe.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>
#import <os/lock.h>

@implementation NSLockTestObject {
    NSLock *_lock;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
        _lock = [[NSLock alloc] init];
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    [_lock lock];
    [_array addObject:object];
    [_lock unlock];
}

- (void)readObject {
    [_lock lock];
    NSUInteger count = _array.count;
    count++;
    [_lock unlock];
}


- (void)writeWithAutoDeleteObject:(NSString *)object {
    [_lock lock];
    if (_array.count < 50) {
        [_array addObject:object];
    }
    else {
        [_array removeObjectsInRange:NSMakeRange(0, 20)];
    }
    [_lock unlock];
}

- (void)deleteObject:(NSUInteger)index {
    [_lock lock];
    [_array removeObjectAtIndex:index];
    [_lock unlock];
}

- (void)findAndDelete:(NSInteger)number {
    [_lock lock];
    for (NSString *content in _array.reverseObjectEnumerator) {
        if (!(content.integerValue / number)) {
            [_array removeObject:content];
        }
    }
    [_lock unlock];
}

- (void)readAllObject {
    [_lock lock];
    __block NSInteger total = 0;
    [_array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += obj.integerValue;
    }];
    [_lock unlock];
}

- (void)findAndChange:(NSInteger)number {
    [_lock lock];
    for (int i = 0; i < _array.count; i++) {
        if (!([_array[i] integerValue] / number)) {
            _array[i] = [NSString stringWithFormat:@"%ld", [_array[i] integerValue] + number];
        }
    }
    [_lock unlock];
}

- (void)lockAndUnlock {
    [_lock lock];
    [_lock unlock];
}

@end

@implementation NSConditionTestObject {
    NSCondition *_condition;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
        _condition = [[NSCondition alloc] init];
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    [_condition lock];
    [_array addObject:object];
    [_condition unlock];
}

- (void)readObject {
    [_condition lock];
    NSUInteger count = _array.count;
    count++;
    [_condition unlock];
}

- (void)writeWithAutoDeleteObject:(NSString *)object {
    [_condition lock];
    if (_array.count < 50) {
        [_array addObject:object];
    }
    else {
        [_array removeObjectsInRange:NSMakeRange(0, 20)];
    }
    [_condition unlock];
}

- (void)deleteObject:(NSUInteger)index {
    [_condition lock];
    [_array removeObjectAtIndex:index];
    [_condition unlock];
}

- (void)findAndDelete:(NSInteger)number {
    [_condition lock];
    for (NSString *content in _array.reverseObjectEnumerator) {
        if (!(content.integerValue / number)) {
            [_array removeObject:content];
        }
    }
    [_condition unlock];
}

- (void)readAllObject {
    [_condition lock];
    __block NSInteger total = 0;
    [_array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += obj.integerValue;
    }];
    [_condition unlock];
}

- (void)findAndChange:(NSInteger)number {
    [_condition lock];
    for (int i = 0; i < _array.count; i++) {
        if (!([_array[i] integerValue] / number)) {
            _array[i] = [NSString stringWithFormat:@"%ld", [_array[i] integerValue] + number];
        }
    }
    [_condition unlock];
}

- (void)lockAndUnlock {
    [_condition lock];
    [_condition unlock];
}

@end

@implementation NSConditionLockTestObject {
    NSConditionLock *_lock;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
        _lock = [[NSConditionLock alloc] init];
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    [_lock lock];
    [_array addObject:object];
    [_lock unlock];
}

- (void)readObject {
    [_lock lock];
    NSUInteger count = _array.count;
    count++;
    [_lock unlock];
}

- (void)writeWithAutoDeleteObject:(NSString *)object {
    [_lock lock];
    if (_array.count < 50) {
        [_array addObject:object];
    }
    else {
        [_array removeObjectsInRange:NSMakeRange(0, 20)];
    }
    [_lock unlock];
}

- (void)deleteObject:(NSUInteger)index {
    [_lock lock];
    [_array removeObjectAtIndex:index];
    [_lock unlock];
}

- (void)findAndDelete:(NSInteger)number {
    [_lock lock];
    for (NSString *content in _array.reverseObjectEnumerator) {
        if (!(content.integerValue / number)) {
            [_array removeObject:content];
        }
    }
    [_lock unlock];
}

- (void)readAllObject {
    [_lock lock];
    __block NSInteger total = 0;
    [_array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += obj.integerValue;
    }];
    [_lock unlock];
}

- (void)findAndChange:(NSInteger)number {
    [_lock lock];
    for (int i = 0; i < _array.count; i++) {
        if (!([_array[i] integerValue] / number)) {
            _array[i] = [NSString stringWithFormat:@"%ld", [_array[i] integerValue] + number];
        }
    }
    [_lock unlock];
}

- (void)lockAndUnlock {
    [_lock lock];
    [_lock unlock];
}

@end

@implementation NSRecursiveLockTestObject {
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
    [_array addObject:object];
    [_lock unlock];
}

- (void)readObject {
    [_lock lock];
    NSUInteger count = _array.count;
    count++;
    [_lock unlock];
}


- (void)writeWithAutoDeleteObject:(NSString *)object {
    [_lock lock];
    if (_array.count < 50) {
        [_array addObject:object];
    }
    else {
        [_array removeObjectsInRange:NSMakeRange(0, 20)];
    }
    [_lock unlock];
}

- (void)deleteObject:(NSUInteger)index {
    [_lock lock];
    [_array removeObjectAtIndex:index];
    [_lock unlock];
}

- (void)findAndDelete:(NSInteger)number {
    [_lock lock];
    for (NSString *content in _array.reverseObjectEnumerator) {
        if (!(content.integerValue / number)) {
            [_array removeObject:content];
        }
    }
    [_lock unlock];
}

- (void)readAllObject {
    [_lock lock];
    __block NSInteger total = 0;
    [_array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += obj.integerValue;
    }];
    [_lock unlock];
}

- (void)findAndChange:(NSInteger)number {
    [_lock lock];
    for (int i = 0; i < _array.count; i++) {
        if (!([_array[i] integerValue] / number)) {
            _array[i] = [NSString stringWithFormat:@"%ld", [_array[i] integerValue] + number];
        }
    }
    [_lock unlock];
}

- (void)lockAndUnlock {
    [_lock lock];
    [_lock unlock];
}

@end

@implementation PthreadMutexTTestObject {
    pthread_mutex_t _t;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
        _t = (pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER;
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    pthread_mutex_lock(&_t);
    [_array addObject:object];
    pthread_mutex_unlock(&_t);
}

- (void)readObject {
    pthread_mutex_lock(&_t);
    NSUInteger count = _array.count;
    count++;
    pthread_mutex_unlock(&_t);
}


- (void)writeWithAutoDeleteObject:(NSString *)object {
    pthread_mutex_lock(&_t);
    if (_array.count < 50) {
        [_array addObject:object];
    }
    else {
        [_array removeObjectsInRange:NSMakeRange(0, 20)];
    }
    pthread_mutex_unlock(&_t);
}

- (void)deleteObject:(NSUInteger)index {
    pthread_mutex_lock(&_t);
    [_array removeObjectAtIndex:index];
    pthread_mutex_unlock(&_t);
}

- (void)findAndDelete:(NSInteger)number {
    pthread_mutex_lock(&_t);
    for (NSString *content in _array.reverseObjectEnumerator) {
        if (!(content.integerValue / number)) {
            [_array removeObject:content];
        }
    }
    pthread_mutex_unlock(&_t);
}

- (void)readAllObject {
    pthread_mutex_lock(&_t);
    __block NSInteger total = 0;
    [_array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += obj.integerValue;
    }];
    pthread_mutex_unlock(&_t);
}

- (void)findAndChange:(NSInteger)number {
    pthread_mutex_lock(&_t);
    for (int i = 0; i < _array.count; i++) {
        if (!([_array[i] integerValue] / number)) {
            _array[i] = [NSString stringWithFormat:@"%ld", [_array[i] integerValue] + number];
        }
    }
    pthread_mutex_unlock(&_t);
}

- (void)lockAndUnlock {
    pthread_mutex_lock(&_t);
    pthread_mutex_unlock(&_t);
}

@end

@implementation DispatchSemaphoreTTestObject {
    dispatch_semaphore_t _t;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
        _t = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    dispatch_semaphore_wait(_t, DISPATCH_TIME_FOREVER);
    [_array addObject:object];
    dispatch_semaphore_signal(_t);
}

- (void)readObject {
    dispatch_semaphore_wait(_t, DISPATCH_TIME_FOREVER);
    NSUInteger count = _array.count;
    count++;
    dispatch_semaphore_signal(_t);
}


- (void)writeWithAutoDeleteObject:(NSString *)object {
    dispatch_semaphore_wait(_t, DISPATCH_TIME_FOREVER);
    if (_array.count < 50) {
        [_array addObject:object];
    }
    else {
        [_array removeObjectsInRange:NSMakeRange(0, 20)];
    }
    dispatch_semaphore_signal(_t);
}

- (void)deleteObject:(NSUInteger)index {
    dispatch_semaphore_wait(_t, DISPATCH_TIME_FOREVER);
    [_array removeObjectAtIndex:index];
    dispatch_semaphore_signal(_t);
}

- (void)findAndDelete:(NSInteger)number {
    dispatch_semaphore_wait(_t, DISPATCH_TIME_FOREVER);
    for (NSString *content in _array.reverseObjectEnumerator) {
        if (!(content.integerValue / number)) {
            [_array removeObject:content];
        }
    }
    dispatch_semaphore_signal(_t);
}

- (void)readAllObject {
    dispatch_semaphore_wait(_t, DISPATCH_TIME_FOREVER);
    __block NSInteger total = 0;
    [_array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += obj.integerValue;
    }];
    dispatch_semaphore_signal(_t);
}

- (void)findAndChange:(NSInteger)number {
    dispatch_semaphore_wait(_t, DISPATCH_TIME_FOREVER);
    for (int i = 0; i < _array.count; i++) {
        if (!([_array[i] integerValue] / number)) {
            _array[i] = [NSString stringWithFormat:@"%ld", [_array[i] integerValue] + number];
        }
    }
    dispatch_semaphore_signal(_t);
}

- (void)lockAndUnlock {
    dispatch_semaphore_wait(_t, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_signal(_t);
    
}


@end

@implementation OSSpinLockTestObject {
    OSSpinLock _lock;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
        _lock = OS_SPINLOCK_INIT;
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    OSSpinLockLock(&_lock);
    [_array addObject:object];
    OSSpinLockUnlock(&_lock);
}

- (void)readObject {
    OSSpinLockLock(&_lock);
    NSUInteger count = _array.count;
    count++;
    OSSpinLockUnlock(&_lock);
}

- (void)writeWithAutoDeleteObject:(NSString *)object {
    OSSpinLockLock(&_lock);
    if (_array.count < 50) {
        [_array addObject:object];
    }
    else {
        [_array removeObjectsInRange:NSMakeRange(0, 20)];
    }
    OSSpinLockUnlock(&_lock);
}

- (void)deleteObject:(NSUInteger)index {
    OSSpinLockLock(&_lock);
    [_array removeObjectAtIndex:index];
    OSSpinLockUnlock(&_lock);
}

- (void)findAndDelete:(NSInteger)number {
    OSSpinLockLock(&_lock);
    for (NSString *content in _array.reverseObjectEnumerator) {
        if (!(content.integerValue / number)) {
            [_array removeObject:content];
        }
    }
    OSSpinLockUnlock(&_lock);
}

- (void)readAllObject {
    OSSpinLockLock(&_lock);
    __block NSInteger total = 0;
    [_array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += obj.integerValue;
    }];
    OSSpinLockUnlock(&_lock);
}

- (void)findAndChange:(NSInteger)number {
    OSSpinLockLock(&_lock);
    for (int i = 0; i < _array.count; i++) {
        if (!([_array[i] integerValue] / number)) {
            _array[i] = [NSString stringWithFormat:@"%ld", [_array[i] integerValue] + number];
        }
    }
    OSSpinLockUnlock(&_lock);
}

- (void)lockAndUnlock {
    OSSpinLockLock(&_lock);
    OSSpinLockUnlock(&_lock);
}

@end

@implementation OSUnfairLockTestObject {
    os_unfair_lock _lock;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _array = [NSMutableArray new];
        _lock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    os_unfair_lock_lock(&_lock);
    [_array addObject:object];
    os_unfair_lock_unlock(&_lock);
}

- (void)readObject {
    os_unfair_lock_lock(&_lock);
    NSUInteger count = _array.count;
    count++;
    os_unfair_lock_unlock(&_lock);
}

- (void)writeWithAutoDeleteObject:(NSString *)object {
    os_unfair_lock_lock(&_lock);
    if (_array.count < 50) {
        [_array addObject:object];
    }
    else {
        [_array removeObjectsInRange:NSMakeRange(0, 20)];
    }
    os_unfair_lock_unlock(&_lock);
}

- (void)deleteObject:(NSUInteger)index {
    os_unfair_lock_lock(&_lock);
    [_array removeObjectAtIndex:index];
    os_unfair_lock_unlock(&_lock);
}

- (void)findAndDelete:(NSInteger)number {
    os_unfair_lock_lock(&_lock);
    for (NSString *content in _array.reverseObjectEnumerator) {
        if (!(content.integerValue / number)) {
            [_array removeObject:content];
        }
    }
    os_unfair_lock_unlock(&_lock);
}

- (void)readAllObject {
    os_unfair_lock_lock(&_lock);
    __block NSInteger total = 0;
    [_array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += obj.integerValue;
    }];
    os_unfair_lock_unlock(&_lock);
}

- (void)findAndChange:(NSInteger)number {
    os_unfair_lock_lock(&_lock);
    for (int i = 0; i < _array.count; i++) {
        if (!([_array[i] integerValue] / number)) {
            _array[i] = [NSString stringWithFormat:@"%ld", [_array[i] integerValue] + number];
        }
    }
    os_unfair_lock_unlock(&_lock);
}

- (void)lockAndUnlock {
    os_unfair_lock_lock(&_lock);
    os_unfair_lock_unlock(&_lock);
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
        [_array addObject:object];
    }
}

- (void)readObject {
    @synchronized (self) {
        NSUInteger count = _array.count;
        count++;
    }
}


- (void)writeWithAutoDeleteObject:(NSString *)object {
    @synchronized (self) {
        if (_array.count < 50) {
            [_array addObject:object];
        }
        else {
            [_array removeObjectsInRange:NSMakeRange(0, 20)];
        }
    }
}

- (void)deleteObject:(NSUInteger)index {
    @synchronized (self) {
        [_array removeObjectAtIndex:index];
    }
}

- (void)findAndDelete:(NSInteger)number {
    @synchronized (self) {
        for (NSString *content in _array.reverseObjectEnumerator) {
            if (!(content.integerValue / number)) {
                [_array removeObject:content];
            }
        }
    }
}

- (void)readAllObject {
    @synchronized (self) {
        __block NSInteger total = 0;
        [_array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            total += obj.integerValue;
        }];
    }
}

- (void)findAndChange:(NSInteger)number {
    @synchronized (self) {
        for (int i = 0; i < _array.count; i++) {
            if (!([_array[i] integerValue] / number)) {
                _array[i] = [NSString stringWithFormat:@"%ld", [_array[i] integerValue] + number];
            }
        }
    }
}

- (void)lockAndUnlock {
    @synchronized (self){
        
    }
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

- (void)readObject {
    dispatch_sync(_queue, ^{
        NSInteger count = self.array.count;
        count++;
    });
}


- (void)writeWithAutoDeleteObject:(NSString *)object {
    dispatch_sync(_queue, ^{
        if (self.array.count < 50) {
            [self.array addObject:object];
        }
        else {
            [self.array removeObjectsInRange:NSMakeRange(0, 20)];
        }
    });
}

- (void)deleteObject:(NSUInteger)index {
    dispatch_sync(_queue, ^{
        [self.array removeObjectAtIndex:index];
    });
}

- (void)findAndDelete:(NSInteger)number {
    dispatch_sync(_queue, ^{
        for (NSString *content in self.array.reverseObjectEnumerator) {
            if (!(content.integerValue / number)) {
                [self.array removeObject:content];
            }
        }
    });
}

- (void)readAllObject {
    dispatch_sync(_queue, ^{
        __block NSInteger total = 0;
        [self.array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            total += obj.integerValue;
        }];
    });
}

- (void)findAndChange:(NSInteger)number {
    dispatch_sync(_queue, ^{
        for (int i = 0; i < self.array.count; i++) {
            if (!([self.array[i] integerValue] / number)) {
                self.array[i] = [NSString stringWithFormat:@"%ld", [self.array[i] integerValue] + number];
            }
        }
    });
}

- (void)lockAndUnlock {
    dispatch_sync(_queue, ^{
        
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

- (void)readObject {
    dispatch_sync(_queue, ^{
        NSUInteger count = self.array.count;
        count++;
    });
}

- (void)writeWithAutoDeleteObject:(NSString *)object {
    dispatch_barrier_sync(_queue, ^{
        if (self.array.count < 50) {
            [self.array addObject:object];
        }
        else {
            [self.array removeObjectsInRange:NSMakeRange(0, 20)];
        }
    });
}

- (void)deleteObject:(NSUInteger)index {
    dispatch_sync(_queue, ^{
        [self.array removeObjectAtIndex:index];
    });
}

- (void)findAndDelete:(NSInteger)number {
    dispatch_sync(_queue, ^{
        for (NSString *content in self.array.reverseObjectEnumerator) {
            if (!(content.integerValue / number)) {
                [self.array removeObject:content];
            }
        }
    });
}

- (void)readAllObject {
    dispatch_sync(_queue, ^{
        __block NSInteger total = 0;
        [self.array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            total += obj.integerValue;
        }];
    });
}

- (void)findAndChange:(NSInteger)number {
    dispatch_sync(_queue, ^{
        for (int i = 0; i < self.array.count; i++) {
            if (!([self.array[i] integerValue] / number)) {
                self.array[i] = [NSString stringWithFormat:@"%ld", [self.array[i] integerValue] + number];
            }
        }
    });
}

- (void)lockAndUnlock {
    dispatch_barrier_sync(_queue, ^{
        
    });
}

@end

@implementation ELThreadSafeTestObject

- (instancetype)init {
    self = [super init];
    if (self) {
        _array = [[NSMutableArray new] el_threadSafeObject];
    }
    return self;
}

- (void)writeObject:(NSString *)object {
    [_array addObject:object];
}

- (void)readObject {
    NSUInteger count = _array.count;
    count++;
}

- (void)writeWithAutoDeleteObject:(NSString *)newObj {
    [_array el_threadSafeAction:^(NSMutableArray *object) {
        if ([object count] < 50) {
            [object addObject:newObj];
        }
        else {
            [object removeObjectsInRange:NSMakeRange(0, 20)];
        }
    }];
}

- (void)deleteObject:(NSUInteger)index {
    [_array removeObjectAtIndex:index];
}

- (void)findAndDelete:(NSInteger)number {
    [_array el_threadSafeAction:^(id object) {
        for (NSString *content in [object reverseObjectEnumerator]) {
            if (!(content.integerValue / number)) {
                [object removeObject:content];
            }
        }
    }];
}

- (void)readAllObject {
    __block NSInteger total = 0;
    [_array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total += obj.integerValue;
    }];
}

- (void)findAndChange:(NSInteger)number {
    [_array el_threadSafeAction:^(NSMutableArray *object) {
        NSInteger count = [object count];
        for (int i = 0; i < count; i++) {
            if (!([object[i] integerValue] / number)) {
                object[i] = [NSString stringWithFormat:@"%ld", [object[i] integerValue] + number];
            }
        }
    }];
}

- (void)lockAndUnlock {
    
}

@end

