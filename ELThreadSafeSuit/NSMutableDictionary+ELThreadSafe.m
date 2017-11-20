//
//  ELThreadSafeDictionary.m
//  ELThreadSafeHelper
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "NSMutableDictionary+ELThreadSafe.h"
#import "ELThreadSafeObject.h"
@interface ELThreadSafeDictionary: ELThreadSafeObject

@end

@implementation ELThreadSafeDictionary

+ (void)load {
    [super load];
    [NSMutableDictionary setEl_threadSafeFilterActionForClass:^BOOL(SEL aSelector) {
        if (!aSelector) {
            return false;
        }
        NSString *selectorName = NSStringFromSelector(aSelector);
        if ([selectorName hasPrefix:@"add"]) {
            return true;
        }
        if ([selectorName hasPrefix:@"remove"]) {
            return true;
        }
        if ([selectorName hasPrefix:@"set"]) {
            return true;
        }
        return false;
    }];
}

- (BOOL)isNSDictionary__ {
    return true;
}

@end

@implementation NSMutableDictionary (ELThreadSafe)

- (instancetype)el_threadSafeObject {
    ELThreadSafeDictionary *object = [[ELThreadSafeDictionary alloc] initWithInnerObject:self];
    return (NSMutableDictionary *)object;
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
