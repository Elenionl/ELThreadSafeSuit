//
//  NSMutableOrderedSet+ELTHreadSafe.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "NSMutableOrderedSet+ELThreadSafe.h"
#import "ELThreadSafeObject.h"

@implementation NSMutableOrderedSet (ELThreadSafe)

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
    [table addObject:NSStringFromSelector(@selector(addObjects:count:))];
    [table addObject:NSStringFromSelector(@selector(addObjectsFromArray:))];
    [table addObject:NSStringFromSelector(@selector(insertObject:atIndex:))];
    [table addObject:NSStringFromSelector(@selector(setObject:atIndexedSubscript:))];
    [table addObject:NSStringFromSelector(@selector(insertObjects:atIndexes:))];
    [table addObject:NSStringFromSelector(@selector(removeObject:))];
    [table addObject:NSStringFromSelector(@selector(removeObjectAtIndex:))];
    [table addObject:NSStringFromSelector(@selector(removeObjectsAtIndexes:))];
    [table addObject:NSStringFromSelector(@selector(removeObjectsInRange:))];
    [table addObject:NSStringFromSelector(@selector(removeAllObjects))];
    [table addObject:NSStringFromSelector(@selector(replaceObjectAtIndex:withObject:))];
    [table addObject:NSStringFromSelector(@selector(replaceObjectsAtIndexes:withObjects:))];
    [table addObject:NSStringFromSelector(@selector(replaceObjectsInRange:withObjects:count:))];
    [table addObject:NSStringFromSelector(@selector(setObject:atIndex:))];
    [table addObject:NSStringFromSelector(@selector(moveObjectsAtIndexes:toIndex:))];
    [table addObject:NSStringFromSelector(@selector(exchangeObjectAtIndex:withObjectAtIndex:))];
    [table addObject:NSStringFromSelector(@selector(filterUsingPredicate:))];
    [table addObject:NSStringFromSelector(@selector(sortUsingDescriptors:))];
    [table addObject:NSStringFromSelector(@selector(sortUsingComparator:))];
    [table addObject:NSStringFromSelector(@selector(sortWithOptions:usingComparator:))];
    [table addObject:NSStringFromSelector(@selector(sortRange:options:usingComparator:))];
    [table addObject:NSStringFromSelector(@selector(intersectOrderedSet:))];
    [table addObject:NSStringFromSelector(@selector(intersectSet:))];
    [table addObject:NSStringFromSelector(@selector(minusOrderedSet:))];
    [table addObject:NSStringFromSelector(@selector(minusSet:))];
    [table addObject:NSStringFromSelector(@selector(unionOrderedSet:))];
    [table addObject:NSStringFromSelector(@selector(unionSet:))];
    return table;
}

+ (instancetype)el_threadSafeOrderedSet {
    NSMutableOrderedSet *object = [[[NSMutableOrderedSet alloc] init] el_threadSafeObject];
    return object;
}

+ (instancetype)el_threadSafeOrderedSetWithCapacity:(NSUInteger)numItems {
    NSMutableOrderedSet *object = [[[NSMutableOrderedSet alloc] initWithCapacity:numItems] el_threadSafeObject];
    return object;
}

@end

@implementation NSOrderedSet (ELThreadSafe)

- (NSMutableOrderedSet *)el_threadSafeMutableCopy {
    return [self.mutableCopy el_threadSafeMutableCopy];
}

@end

