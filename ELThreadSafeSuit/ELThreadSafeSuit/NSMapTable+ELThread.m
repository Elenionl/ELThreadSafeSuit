//
//  NSMapTable+ELThread.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/12/9.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "NSMapTable+ELThread.h"
#import "ELThreadSafeObject.h"
@implementation NSMapTable (ELThreadSafe)

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
    [table addObject:NSStringFromSelector(@selector(setObject:forKey:))];
    [table addObject:NSStringFromSelector(@selector(removeObjectForKey:))];
    [table addObject:NSStringFromSelector(@selector(removeAllObjects))];
    return table;
}

@end
