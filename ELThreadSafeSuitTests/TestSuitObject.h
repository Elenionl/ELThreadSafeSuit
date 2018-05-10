//
//  TestSuitObject.h
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/21.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LockUnlockType<NSObject>

- (void)lockAndUnlock;

@end

@protocol ReadWriteType<NSObject>

- (void)writeObject:(NSString *)object;
- (void)readObject;

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

@protocol MessagePoolType<NSObject>

@required
- (void)writeWithAutoDeleteObject:(NSString *)object;
- (void)deleteObject:(NSUInteger)index;
- (void)findAndDelete:(NSInteger)number;
- (void)readAllObject;
- (void)findAndChange:(NSInteger)number;
@end

@interface NSLockTestObject : NSObject<LockUnlockType, ReadWriteType, MessagePoolType>

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

@interface NSConditionTestObject : NSObject<LockUnlockType, ReadWriteType, MessagePoolType>

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

@interface NSConditionLockTestObject : NSObject<LockUnlockType, ReadWriteType, MessagePoolType>

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

@interface NSRecursiveLockTestObject : NSObject<LockUnlockType, ReadWriteType, MessagePoolType>

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

@interface PthreadMutexTTestObject : NSObject<LockUnlockType, ReadWriteType, MessagePoolType>

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

@interface DispatchSemaphoreTTestObject : NSObject<LockUnlockType, ReadWriteType, MessagePoolType>

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

@interface OSSpinLockTestObject : NSObject<LockUnlockType, ReadWriteType, MessagePoolType>

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

@interface OSUnfairLockTestObject : NSObject<LockUnlockType, ReadWriteType, MessagePoolType>

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

@interface SyncSelfTestObject: NSObject<LockUnlockType, ReadWriteType, MessagePoolType>

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

@interface SerialQueueTestObject: NSObject<LockUnlockType, ReadWriteType, MessagePoolType>

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

@interface ConcurrentQueueBarriarTestObject: NSObject<LockUnlockType, ReadWriteType, MessagePoolType>

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

@interface ELThreadSafeTestObject: NSObject<LockUnlockType, ReadWriteType, MessagePoolType>

@property (nonatomic, strong) NSMutableArray<NSString *> *array;

@end

