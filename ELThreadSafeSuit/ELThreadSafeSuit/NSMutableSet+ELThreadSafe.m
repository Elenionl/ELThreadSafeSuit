//
//  NSMutableSet+ELThreadSafe.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/21.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "NSMutableSet+ELThreadSafe.h"
#import "ELThreadSafeObject.h"

@implementation NSMutableSet (ELThreadSafe)

- (instancetype)el_threadSafeObject {
    NSHashTable *protectTable = [self protectTable];
    id object = [super el_threadSafeObject];
    [object setEl_threadSafeFilterActionForInstance:^BOOL(SEL aSelector) {
        return [protectTable containsObject:NSStringFromSelector(aSelector)];
    }];
    return object;
}

- (NSHashTable *)protectTable {
    NSHashTable *table = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
    [table addObject:NSStringFromSelector(@selector(addObject:))];
    [table addObject:NSStringFromSelector(@selector(filterUsingPredicate:))];
    [table addObject:NSStringFromSelector(@selector(removeObject:))];
    [table addObject:NSStringFromSelector(@selector(removeAllObjects))];
    [table addObject:NSStringFromSelector(@selector(addObjectsFromArray:))];
    [table addObject:NSStringFromSelector(@selector(unionSet:))];
    [table addObject:NSStringFromSelector(@selector(minusSet:))];
    [table addObject:NSStringFromSelector(@selector(intersectSet:))];
    [table addObject:NSStringFromSelector(@selector(setSet:))];
    return table;
}

+ (instancetype)el_threadSafeSet {
    NSMutableSet *object= [[[NSMutableSet alloc] init] el_threadSafeObject];
    return object;
}

+ (instancetype)el_threadSafeSetWithCapacity:(NSUInteger)numItems {
    NSMutableSet *object = [[[NSMutableSet alloc] initWithCapacity:numItems] el_threadSafeObject];
    return object;
}

@end

@implementation NSSet (ELThreadSafe)

- (NSMutableArray *)el_threadSafeMutableCopy {
    return [self.mutableCopy el_threadSafeObject];
}

@end
