//
//  MapsSampleTests.m
//  MapsSampleTests
//
//  Created by NS on 3/9/16.
//  Copyright © 2016 Sinhngn. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "ShareData.h"

@interface MapsSampleTests : XCTestCase

@property ViewController *viewController;

@end

@implementation MapsSampleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// Data input right
- (void)testGetAPITakeSomeTime_success {
    
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Long method Call API"];
    
    [[ShareData instance].directionsProxy getDirection:@"10.000,20.000" destination:@"40.000,20.000" completed:^(id result, NSString *errorCode, NSString *message) {
        XCTAssertTrue(errorCode,@"");
        [completionExpectation fulfill];
    } error:^(id result, NSString *errorCode, NSString *message) {
        
    }];
    

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        
    }];
}

// Data input null
- (void)testGetAPITakeSomeTime_Failed {
    
    XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Long method CALL API"];
    
    [[ShareData instance].directionsProxy getDirection:@"" destination:@"" completed:^(id result, NSString *errorCode, NSString *message) {
        XCTAssertTrue(errorCode,@"");
        [completionExpectation fulfill];
    } error:^(id result, NSString *errorCode, NSString *message) {
        
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        
    }];
}

- (void)testPerformanceExample {
        XCTestExpectation *completionExpectation = [self expectationWithDescription:@"Long method CALL API"];
    
    // This is an example of a performance test case.
    [self measureBlock:^{
        
        for(int i =0 ; i == 100000 ;i++){
        // Put the code you want to measure the time of here.
        [[ShareData instance].directionsProxy getDirection:@"3939" destination:@"ff" completed:^(id result, NSString *errorCode, NSString *message) {
            
            [completionExpectation fulfill];
            
        } error:^(id result, NSString *errorCode, NSString *message) {
            
            [completionExpectation fulfill];
            
        }];
        
        [self waitForExpectationsWithTimeout:2.0 handler:^(NSError * _Nullable error) {
            
        }];
        }
        
    }];
}

@end
