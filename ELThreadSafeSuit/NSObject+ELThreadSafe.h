//
//  NSObject+ELThreadSafe.h
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^ELThreadSafeFilterAction)(SEL aSelector);

typedef void(^ELThreadSafeSetAction)(id object);

@interface NSObject (ELThreadSafe)

@property (class, nonatomic, copy) ELThreadSafeFilterAction el_threadSafeFilterActionForClass;
@property (nonatomic, copy) ELThreadSafeFilterAction el_threadSafeFilterActionForInstance;
@property (nonatomic, readonly) BOOL el_isThreadSafe;
@property (nonatomic, readonly) id el_normalObject;
@property (nonatomic, readonly) id el_threadSafeObject;

- (void)el_threadSafeAction:(ELThreadSafeSetAction)action;

@end
