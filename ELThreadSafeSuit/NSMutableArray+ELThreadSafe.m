//
//  ELThreadSafeArray.m
//  UnitTest
//
//  Created by Elenion on 2017/10/16.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "NSMutableArray+ELThreadSafe.h"
#import "ELThreadSafeObject.h"

@implementation NSMutableArray (ELThreadSafe)

- (instancetype)el_threadSafeObject {
    
    id object = [super el_threadSafeObject];
    NSHashTable *protectTable = [self protectTable];
    [object setEl_threadSafeFilterActionForInstance:^BOOL(SEL aSelector) {
        return [protectTable containsObject:NSStringFromSelector(aSelector)];
    }];
    return object;
}

- (NSHashTable *)protectTable {
    NSHashTable *table = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
    
    [table addObject:NSStringFromSelector(@selector(addObject:))];
    [table addObject:NSStringFromSelector(@selector(addObjectsFromArray:))];
    [table addObject:NSStringFromSelector(@selector(insertObject:atIndex:))];
    [table addObject:NSStringFromSelector(@selector(insertObjects:atIndexes:))];
    [table addObject:NSStringFromSelector(@selector(removeAllObjects))];
    [table addObject:NSStringFromSelector(@selector(removeLastObject))];
    [table addObject:NSStringFromSelector(@selector(removeObject:))];
    [table addObject:NSStringFromSelector(@selector(removeObject:inRange:))];
    [table addObject:NSStringFromSelector(@selector(removeObjectAtIndex:))];
    [table addObject:NSStringFromSelector(@selector(removeObjectsAtIndexes:))];
    [table addObject:NSStringFromSelector(@selector(removeObjectIdenticalTo:))];
    [table addObject:NSStringFromSelector(@selector(removeObjectIdenticalTo:inRange:))];
    [table addObject:NSStringFromSelector(@selector(removeObjectsFromIndices:numIndices:))];
    [table addObject:NSStringFromSelector(@selector(removeObjectsInArray:))];
    [table addObject:NSStringFromSelector(@selector(removeObject:inRange:))];
    [table addObject:NSStringFromSelector(@selector(replaceObjectAtIndex:withObject:))];
    [table addObject:NSStringFromSelector(@selector(setObject:atIndexedSubscript:))];
    [table addObject:NSStringFromSelector(@selector(replaceObjectsAtIndexes:withObjects:))];
    [table addObject:NSStringFromSelector(@selector(replaceObjectsInRange:withObjectsFromArray:range:
))];
    [table addObject:NSStringFromSelector(@selector(replaceObjectsInRange:withObjectsFromArray:))];
    [table addObject:NSStringFromSelector(@selector(setArray:))];
    [table addObject:NSStringFromSelector(@selector(filterUsingPredicate:))];
    [table addObject:NSStringFromSelector(@selector(exchangeObjectAtIndex:withObjectAtIndex:))];
    [table addObject:NSStringFromSelector(@selector(sortUsingDescriptors:))];
    [table addObject:NSStringFromSelector(@selector(sortUsingComparator:))];
    [table addObject:NSStringFromSelector(@selector(sortWithOptions:usingComparator:))];
    [table addObject:NSStringFromSelector(@selector(sortUsingFunction:context:))];
    [table addObject:NSStringFromSelector(@selector(sortUsingSelector:))];
    return table;
    
}

+ (instancetype)el_threadSafeArray {
    NSMutableArray *object = [[[NSMutableArray alloc] init] el_threadSafeObject];
    return object;
}

+ (instancetype)el_threadSafeArrayWithCapacity:(NSUInteger)numItems {
    NSMutableArray *object = [[NSMutableArray arrayWithCapacity:numItems] el_threadSafeObject];
    return object;
}

@end

@implementation NSArray (ELThreadSafe)

- (NSMutableArray *)el_threadSafeMutableCopy {
    return [self.mutableCopy el_threadSafeObject];
}

@end
