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

@property (strong) NSMutableArray *array;

@optional

- (void)readObject:(NSString *)object;

@end

@interface OriginTestObject<TestSuitType> : NSObject

@property (nonatomic, strong) NSMutableArray *array;

- (void)writeObject:(NSString *)object;

@end

@interface AtomicTestObject<TestSuitType> : NSObject

@property (atomic, strong) NSMutableArray *array;

- (void)writeObject:(NSString *)object;

@end

@interface LockTestObject<TestSuitType> : NSObject

@property (atomic, strong) NSMutableArray *array;

- (void)writeObject:(NSString *)object;

@end

@interface SyncTestObject<TestSuitType> : NSObject

@property (atomic, strong) NSMutableArray *array;

- (void)writeObject:(NSString *)object;

@end

