//
//  ELThreadSafeDictionary.m
//  ELThreadSafeHelper
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "NSMutableDictionary+ELThreadSafe.h"
#import "ELThreadSafeObject.h"

@implementation NSMutableDictionary (ELThreadSafe)

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
    [table addObject:NSStringFromSelector(@selector(setObject:forKey:))];
    [table addObject:NSStringFromSelector(@selector(setObject:forKeyedSubscript:))];
    [table addObject:NSStringFromSelector(@selector(setValue:forKey:))];
    [table addObject:NSStringFromSelector(@selector(addEntriesFromDictionary:))];
    [table addObject:NSStringFromSelector(@selector(setDictionary:))];
    [table addObject:NSStringFromSelector(@selector(removeObjectForKey:))];
    [table addObject:NSStringFromSelector(@selector(removeAllObjects))];
    [table addObject:NSStringFromSelector(@selector(removeObjectsForKeys:))];
    return table;
}

+ (instancetype)el_threadSafeDictionary {
    NSMutableDictionary *object = [[[NSMutableDictionary alloc] init] el_threadSafeObject];
    return object;
}

+ (instancetype)el_threadSafeDictionaryWithCapacity:(NSUInteger)numItems {
    NSMutableDictionary *object = [[self dictionaryWithCapacity:numItems] el_threadSafeObject];

    return object;
}

@end

@implementation NSDictionary (ELThreadSafe)

- (NSMutableDictionary *)el_threadSafeMutableCopy {
    return [self.mutableCopy el_threadSafeObject];
}

@end
