//
//  LockTestSuitObject.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/12/5.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "LockTestSuitObject.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>
#import <os/lock.h>
@implementation SynchronizedTest

- (void)testWithLoop:(NSUInteger)loop {
    NSObject *object = [[NSObject alloc] init];
    for (int i = 0; i < loop; i++) {
        @synchronized(object) {
            
        }
    }
}

@end

@implementation NSLockTest

- (void)testWithLoop:(NSUInteger)loop {
    NSLock *lock = [[NSLock alloc] init];
    for (int i = 0; i < loop; i++) {
        [lock lock];
        [lock unlock];
    }
}

@end

@implementation NSConditionTest

- (void)testWithLoop:(NSUInteger)loop {
    NSCondition *condition = [[NSCondition alloc] init];
    for (int i = 0; i < loop; i++) {
        [condition lock];
        [condition unlock];
    }
}

@end

@implementation NSConditionLockTest

- (void)testWithLoop:(NSUInteger)loop {
    NSConditionLock *conditionLock = [[NSConditionLock alloc] init];
    for (int i = 0; i < loop; i++) {
        [conditionLock lock];
        [conditionLock unlock];
    }
}

@end

@implementation NSRecursiveLockTest

- (void)testWithLoop:(NSUInteger)loop {
    NSRecursiveLock *recursiveLock = [[NSRecursiveLock alloc] init];
    for (int i = 0; i < loop; i++) {
        [recursiveLock lock];
        [recursiveLock unlock];
    }
}

@end

@implementation PthreadMutexTTest

- (void)testWithLoop:(NSUInteger)loop {
    pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
    for (int i = 0; i < loop; i++) {
        pthread_mutex_lock(&mutex);
        pthread_mutex_unlock(&mutex);
    }
}

@end

@implementation DispatchSemaphoreTTest

- (void)testWithLoop:(NSUInteger)loop {
    dispatch_semaphore_t t = dispatch_semaphore_create(1);
    for (int i = 0; i < loop; i++) {
        dispatch_semaphore_wait(t, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_signal(t);
    }
}

@end

@implementation OSSpinLockTest

- (void)testWithLoop:(NSUInteger)loop {
    OSSpinLock spinlock = OS_SPINLOCK_INIT;
    for (int i = 0; i < loop; i++) {
        OSSpinLockLock(&spinlock);
        OSSpinLockUnlock(&spinlock);
    }
}

@end

@implementation OSUnfairLockTest

- (void)testWithLoop:(NSUInteger)loop {
    os_unfair_lock unfairLock = OS_UNFAIR_LOCK_INIT;
    for (int i = 0; i < loop; i++) {
        os_unfair_lock_lock(&unfairLock);
        os_unfair_lock_unlock(&unfairLock);
    }
}

@end

@implementation AsyncBarriarTest

- (void)testWithLoop:(NSUInteger)loop {
    for (int i = 0; i < loop; i++) {
        dispatch_barrier_async(dispatch_get_main_queue(), ^{
        });
    }
}

@end

