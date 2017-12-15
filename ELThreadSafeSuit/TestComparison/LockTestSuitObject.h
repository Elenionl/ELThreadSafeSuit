//
//  LockTestSuitObject.h
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/12/5.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LockTestSuitType<NSObject>

- (void)testWithLoop:(NSUInteger)loop;

@end

@interface SynchronizedTest : NSObject<LockTestSuitType>

@end

@interface NSLockTest : NSObject<LockTestSuitType>

@end

@interface NSConditionTest : NSObject<LockTestSuitType>

@end

@interface NSConditionLockTest : NSObject<LockTestSuitType>

@end

@interface NSRecursiveLockTest : NSObject<LockTestSuitType>

@end

@interface PthreadMutexTTest : NSObject<LockTestSuitType>

@end

@interface DispatchSemaphoreTTest : NSObject<LockTestSuitType>

@end

@interface OSSpinLockTest : NSObject<LockTestSuitType>

@end

@interface OSUnfairLockTest : NSObject<LockTestSuitType>

@end

@interface AsyncBarriarTest : NSObject<LockTestSuitType>

@end
