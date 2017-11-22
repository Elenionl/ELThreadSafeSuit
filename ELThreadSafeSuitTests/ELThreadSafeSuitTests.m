//
//  ELThreadSafeSuitTests.m
//  ELThreadSafeSuitTests
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSMutableArray+ELThreadSafe.h"
@interface ELThreadSafeSuitTests : XCTestCase

@end

@implementation ELThreadSafeSuitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIsMemberOfClass {
    NSMutableArray *array = [[NSMutableArray new] el_threadSafeObject];
    
}

@end
