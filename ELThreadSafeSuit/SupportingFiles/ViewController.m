//
//  ViewController.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+ELThreadSafe.h"
#import "TestSuitObject.h"

typedef enum : NSUInteger {
    SimpleLockUnlockTestType,
    SimpleReadWriteTestType,
    LiveRoomSimulateTestType,
} TestType;

typedef void(^TimeBlock)(void);

@interface ViewController ()

@property (nonatomic, assign)TestType testType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testType = LiveRoomSimulateTestType;
    [self test];
}

- (void)test {
    sleep(0.1);
    [self testNSLock];
    sleep(0.1);
    [self testNSCondition];
    sleep(0.1);
    [self testNSConditionLock];
    sleep(0.1);
    [self testNSRecursiveLock];
    sleep(0.1);
    [self testPthreadMutexT];
    sleep(0.1);
    [self testDispatchSemaphoreT];
    sleep(0.1);
    [self testOSSpinLock];
    sleep(0.1);
    [self testOSUnfairLock];
    sleep(0.1);
    [self testSyncSelf];
    sleep(0.1);
    [self testSerialSync];
    sleep(0.1);
    [self testSerialAsync];
    sleep(0.1);
    [self testElThreadSafe];
}


- (void)testNSLock {
    NSLockTestObject *object = [[NSLockTestObject alloc] init];
    [self testWithObject:object];
}

- (void)testNSCondition {
    NSConditionTestObject *object = [[NSConditionTestObject alloc] init];
    [self testWithObject:object];
}

- (void)testNSConditionLock {
    
    NSConditionLockTestObject *object = [[NSConditionLockTestObject alloc] init];
    [self testWithObject:object];
    
}

- (void)testNSRecursiveLock {
    
    NSRecursiveLockTestObject *object = [[NSRecursiveLockTestObject alloc] init];
    [self testWithObject:object];
    
}

- (void)testPthreadMutexT {
    
    PthreadMutexTTestObject *object = [[PthreadMutexTTestObject alloc] init];
    [self testWithObject:object];
    
}

- (void)testDispatchSemaphoreT {
    
    DispatchSemaphoreTTestObject *object = [[DispatchSemaphoreTTestObject alloc] init];
    [self testWithObject:object];
    
}

- (void)testOSSpinLock {
    
    OSSpinLockTestObject *object = [[OSSpinLockTestObject alloc] init];
    [self testWithObject:object];
    
}

- (void)testOSUnfairLock {
    
    OSUnfairLockTestObject *object = [[OSUnfairLockTestObject alloc] init];
    [self testWithObject:object];
    
}

- (void)testSyncSelf {
    
    SyncSelfTestObject *object = [[SyncSelfTestObject alloc] init];
    [self testWithObject:object];
    
}

- (void)testSerialSync {
    
    SerialQueueTestObject *object = [[SerialQueueTestObject alloc] init];
    [self testWithObject:object];
    
}

- (void)testSerialAsync {
    
    ConcurrentQueueBarriarTestObject *object = [[ConcurrentQueueBarriarTestObject alloc] init];
    [self testWithObject:object];
    
}

- (void)testElThreadSafe {
    
    ElTHreadSafeTestObject *object = [[ElTHreadSafeTestObject alloc] init];
    [self testWithObject:object];
    
}

- (void)testWithObject:(id)object {
    switch (self.testType) {
        case SimpleLockUnlockTestType:
            [self testLockUnlockWithObject:object];
            break;
        case SimpleReadWriteTestType:
            [self testReadWriteWithObject:object];
            break;
        case LiveRoomSimulateTestType:
            [self testLiveRoomWithObject:object];
            break;
            
    }
}

- (void)testLiveRoomWithObject:(id<MessagePoolType>)object {
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    //    NSLog(@"Object: %@ StartTime: %f", object, startTime);
    dispatch_apply(1000000, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t count) {
        if (!(count % 58)) {
            [object findAndDelete:20];
        }
        if (!(count % 29)) {
            [object findAndChange:33];
        }
        if (!(count % 5)) {
            [object writeWithAutoDeleteObject:[@(count) description]];
        }
        [object readAllObject];
    });
    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
    //    NSLog(@"Object: %@ EndTime: %f", object, endTime);
    NSLog(@"Object: %@ TimeInterval: %f", object, (endTime - startTime));
}

- (void)testReadWriteWithObject:(id<ReadWriteType>)object {
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    //    NSLog(@"Object: %@ StartTime: %f", object, startTime);
    dispatch_apply(1000000, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t count) {
        if (count % 5) {
            [object writeObject:@(count).description];
        }
        [object readObject];
    });
    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
    //    NSLog(@"Object: %@ EndTime: %f", object, endTime);
    NSLog(@"Object: %@ TimeInterval: %f", object, (endTime - startTime));
}

- (void)testLockUnlockWithObject:(id<LockUnlockType>)object {
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    //    NSLog(@"Object: %@ StartTime: %f", object, startTime);
    for (int i = 0 ; i < 50000000; i++) {
        [object lockAndUnlock];
    }
    CFAbsoluteTime endTime = CFAbsoluteTimeGetCurrent();
    //    NSLog(@"Object: %@ EndTime: %f", object, endTime);
    NSLog(@"Object: %@ TimeInterval: %f", object, (endTime - startTime));
}

@end
