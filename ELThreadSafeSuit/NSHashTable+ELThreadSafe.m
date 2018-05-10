//
//  NSHashTable+ELThreadSafe.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/12/8.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "NSHashTable+ELThreadSafe.h"
#import "ELThreadSafeObject.h"

@implementation NSHashTable (ELThreadSafe)

- (id)el_threadSafeObject {
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
    [table addObject:NSStringFromSelector(@selector(removeObject:))];
    [table addObject:NSStringFromSelector(@selector(removeAllObjects))];
    [table addObject:NSStringFromSelector(@selector(intersectHashTable:))];
    [table addObject:NSStringFromSelector(@selector(intersectsHashTable:))];
    [table addObject:NSStringFromSelector(@selector(minusHashTable:))];
    [table addObject:NSStringFromSelector(@selector(unionHashTable:))];
    return table;
}

@end
