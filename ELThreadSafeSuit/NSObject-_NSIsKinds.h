//
//  NSObject-_NSIsKinds.h
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/21.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (__NSIsKinds)

- (BOOL)isNSValue__;
- (BOOL)isNSTimeZone__;
- (BOOL)isNSString__;
- (BOOL)isNSSet__;
- (BOOL)isNSOrderedSet__;
- (BOOL)isNSNumber__;
- (BOOL)isNSDictionary__;
- (BOOL)isNSDate__;
- (BOOL)isNSData__;
- (BOOL)isNSArray__;

@end
