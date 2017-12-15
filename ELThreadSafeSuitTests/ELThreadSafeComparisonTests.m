//
//  ELThreadSafeComparisonTests.m
//  ELThreadSafeSuitTests
//
//  Created by Elenion on 2017/11/21.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestSuitObject.h"
#define TEST dispatch_apply(5000, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {if (i % 3 || i == 0) { [object writeObject:@"123"]; } else {[object readObject]; }});

@interface ELThreadSafeComparisonTests: XCTestCase

@end

@implementation ELThreadSafeComparisonTests

//- (void)testOrigin {
//    [self measureBlock:^{
//        OriginTestObject *object = [[OriginTestObject alloc] init];
//        TEST
//    }];
//}
//
//- (void)testAtomic {
//    [self measureBlock:^{
//        AtomicTestObject *object = [[AtomicTestObject alloc] init];
//        TEST
//    }];
//}

- (void)testWithObject:(id<TestAsMessagePoolType>)object {
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"Object: %@ StartTime: %f", object, startTime);
    dispatch_apply(10000, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t count) {
        if (!(count % 58)) {
            [object findAndDelete:20];
        }
        if (!(count % 29)) {
            [object findAndChange:33];
        }
        if (!(count % 2)) {
            [object writeWithAutoDeleteObject:[@(count) description]];
            
        }
        [object readAllObject];
    });
    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
    NSLog(@"Object: %@ EndTime: %f", object, endTime);
    NSLog(@"Object: %@ TimeInterval: %f", object, (endTime - startTime));
}

- (void)testNSLock {
    [self measureBlock:^{
        NSLockTestObject *object = [[NSLockTestObject alloc] init];
        [self testWithObject:object];
    }];
}

- (void)testNSCondition {
    [self measureBlock:^{
        NSConditionTestObject *object = [[NSConditionTestObject alloc] init];
        [self testWithObject:object];
    }];
}

- (void)testNSConditionLock {
    [self measureBlock:^{
        NSConditionLockTestObject *object = [[NSConditionLockTestObject alloc] init];
        [self testWithObject:object];
    }];
}

- (void)testNSRecursiveLock {
    [self measureBlock:^{
        NSRecursiveLockTestObject *object = [[NSRecursiveLockTestObject alloc] init];
        [self testWithObject:object];
    }];
}

- (void)testPthreadMutexT {
    [self measureBlock:^{
        PthreadMutexTTestObject *object = [[PthreadMutexTTestObject alloc] init];
        [self testWithObject:object];
    }];
}

- (void)testDispatchSemaphoreT {
    [self measureBlock:^{
        DispatchSemaphoreTTestObject *object = [[DispatchSemaphoreTTestObject alloc] init];
        [self testWithObject:object];
    }];
}

- (void)testOSSpinLock {
    [self measureBlock:^{
        OSSpinLockTestObject *object = [[OSSpinLockTestObject alloc] init];
        [self testWithObject:object];
    }];
}

- (void)testOSUnfairLock {
    [self measureBlock:^{
        OSUnfairLockTestObject *object = [[OSUnfairLockTestObject alloc] init];
        [self testWithObject:object];
    }];
}

- (void)testSyncSelf {
    [self measureBlock:^{
        SyncSelfTestObject *object = [[SyncSelfTestObject alloc] init];
        [self testWithObject:object];
    }];
}

- (void)testSerialSync {
    [self measureBlock:^{
        SerialQueueTestObject *object = [[SerialQueueTestObject alloc] init];
        [self testWithObject:object];
    }];
}

- (void)testSerialAsync {
    [self measureBlock:^{
        ConcurrentQueueBarriarTestObject *object = [[ConcurrentQueueBarriarTestObject alloc] init];
        [self testWithObject:object];
    }];
}

- (void)testElThreadSafe {
    [self measureBlock:^{
        ElTHreadSafeTestObject *object = [[ElTHreadSafeTestObject alloc] init];
        [self testWithObject:object];
    }];
}

@end
