//
//  TestSuitObject.h
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/21.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TestSuitType<NSObject>

- (void)writeObject:(NSString *)object;
- (void)readObject:(NSString *)object;

@property (strong) NSMutableArray *array;

@end

@protocol TestAsMessagePoolType<NSObject>

- (void)readObjects;
- (void)randomReadObject;

@end

@interface OriginTestObject<TestSuitType> : NSObject

@property (nonatomic, strong) NSMutableArray *array;

- (void)writeObject:(NSString *)object;
- (void)readObject:(NSString *)object;
@end

@interface AtomicTestObject<TestSuitType> : NSObject

@property (atomic, strong) NSMutableArray *array;

- (void)writeObject:(NSString *)object;
- (void)readObject:(NSString *)object;
@end

@interface LockTestObject<TestSuitType> : NSObject

@property (atomic, strong) NSMutableArray *array;

- (void)writeObject:(NSString *)object;
- (void)readObject:(NSString *)object;
@end

@interface SyncSelfTestObject<TestSuitType> : NSObject

@property (atomic, strong) NSMutableArray *array;

- (void)writeObject:(NSString *)object;
- (void)readObject:(NSString *)object;
@end

@interface SerialQueueTestObject<TestSuitType> : NSObject

@property (atomic, strong) NSMutableArray *array;

- (void)writeObject:(NSString *)object;
- (void)readObject:(NSString *)object;

@end

@interface ConcurrentQueueBarriarTestObject<TestSuitType> : NSObject

@property (atomic, strong) NSMutableArray *array;

- (void)writeObject:(NSString *)object;
- (void)readObject:(NSString *)object;
@end

@interface ElTHreadSafeTestObject<TestSuitType> : NSObject

@property (atomic, strong) NSMutableArray *array;

- (void)writeObject:(NSString *)object;
- (void)readObject:(NSString *)object;
@end

