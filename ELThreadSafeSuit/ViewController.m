//
//  ViewController.m
//  ELThreadSafeSuit
//
//  Created by Elenion on 2017/11/20.
//  Copyright © 2017年 Elenion. All rights reserved.
//

#import "ViewController.h"
#import "ELThreadSafeArray.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = @[@13, @14, @15, @16, @17, @18].threadSafeMutableCopy;
    NSLog(@"%@", array);
    NSMutableArray *testOne = [[NSMutableArray alloc] init];
    [testOne addObjectsFromArray:array];
    NSLog(@"%@", testOne);
    NSMutableArray *testTwo = array.mutableCopy;
    [testTwo removeObjectsInArray:array];
    NSLog(@"%@", testTwo);
    NSArray *testThree = [@[] arrayByAddingObjectsFromArray:array];
    NSLog(@"%@", testThree);
    NSArray *testFour = @[@1].threadSafeMutableCopy.normalArray.threadSafeMutableCopy.normalArray.threadSafeMutableCopy.normalArray;
}


@end
