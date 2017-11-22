//
//  ELThreadSafeComparisonTests.m
//  ELThreadSafeSuitTests
//
//  Created by Elenion on 2017/11/21.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestSuitObject.h"
#define TEST dispatch_apply(100000, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {if (i % 3 || i == 0) { [object writeObject:@"123"]; } else {[object readObject:@"123"]; }});

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

- (void)testLock {
    [self measureBlock:^{
        LockTestObject *object = [[LockTestObject alloc] init];
        TEST
    }];
}

- (void)testSyncSelf {
    [self measureBlock:^{
        SyncSelfTestObject *object = [[SyncSelfTestObject alloc] init];
        TEST
    }];
}

- (void)testSerialSyncSelf {
    [self measureBlock:^{
        SerialQueueTestObject *object = [[SerialQueueTestObject alloc] init];
        TEST
    }];
}

- (void)testSerialAsyncSelf {
    [self measureBlock:^{
        ConcurrentQueueBarriarTestObject *object = [[ConcurrentQueueBarriarTestObject alloc] init];
        TEST
    }];
}

- (void)testElThreadSafe {
    [self measureBlock:^{
        ElTHreadSafeTestObject *object = [[ElTHreadSafeTestObject alloc] init];
        TEST
    }];
}

@end
