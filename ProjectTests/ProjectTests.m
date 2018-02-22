
#import <XCTest/XCTest.h>
#import "HomeViewController.h"
#import "URLConnection.h"
@interface ProjectTests : XCTestCase
@property HomeViewController *homeVCTest;
@property NSURLSession *testSessionConnection;
@property(strong)  NSString *actualResult;
@property(strong)  NSString *execptedResult;
@end

@implementation ProjectTests

- (void)setUp {
    [super setUp];
    
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
- (void)testgetAPIResponse {
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Async API call for app actual result"];
    [[[HomeViewController alloc]init] completionWithHandler:^(NSString *responseString) {
        _actualResult = responseString;
        XCTAssertNotNil(_actualResult,@"Response was nil");
        [self testDataTask];
        [expectation fulfill];
        
    }];
    //The API call should return within 20 seconds
    [self waitForExpectations:@[expectation] timeout:20.0];
    
    
}
-(void)testDataTask{
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Async API call for expected result"];
    NSURL * url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        _execptedResult = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        XCTAssert([_execptedResult isEqualToString:_actualResult]==true,@"Failed both responses are not same");
        [expectation fulfill];
        
    }];
    [dataTask resume];
    //The API call should return within 20 seconds
    [self waitForExpectations:@[expectation] timeout:20.0];
    
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end

