//
//  GoogleJSONParserTest.m
//  FindOnTheWay
//
//  Created by jyaunche on 1/17/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import "GoogleJSONParserTest.h"
#import "GoogleJSONParser.h"
#import "BasicRouteStep.h"

@implementation GoogleJSONParserTest

-(void)testShouldParseValidJSON{

    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"brooklyn_to_baltimore" ofType:@"json"];
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:filePath];

    NSArray *result = [GoogleJSONParser parsePlacesJSON:data];
}

- (void)testParsingPlacesReturnsNULLWhenJSONInvalid{
    NSMutableData *invalidJSON = [NSMutableData dataWithBytes:@"jfls" length:10];
    NSArray *places = [GoogleJSONParser parsePlacesJSON:invalidJSON];
    STAssertNil(places, @"Should return NULL when invalid json");
}

- (void)testParsingPlacesReturnsNULLWhenResponseStatusIsBad{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"bad_status_response" ofType:@"json"];
    NSMutableData *badResponseData = [NSMutableData dataWithContentsOfFile:filePath];

    NSArray *places = [GoogleJSONParser parsePlacesJSON:badResponseData];
    STAssertNil(places, @"Should return NULL when invalid json");
}

- (void)testParsingValidDirctionJSON{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"brooklyn_to_forest_hill" ofType:@"json"];
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:filePath];

    NSArray *steps = [GoogleJSONParser parseDirectionsJSON:data];
    BasicRouteStep *lastStep = (BasicRouteStep *)steps.lastObject;

    STAssertTrue((steps.count == 10), @"There were actually %i", steps.count);
    STAssertEquals(lastStep.endLocation.latitude, 40.699970f, @"Route steps not being calculated");
}

- (void)testParsingDirectionJSONShouldDetermineIfStepIsResidentialOrHighway{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"brooklyn_to_forest_hill" ofType:@"json"];
    NSMutableData *data = [NSMutableData dataWithContentsOfFile:filePath];

    NSArray *steps = [GoogleJSONParser parseDirectionsJSON:data];
    BasicRouteStep *highwayStep = (BasicRouteStep *) [steps objectAtIndex:6];
    BasicRouteStep *firstStep = (BasicRouteStep *) [steps objectAtIndex:0];

    STAssertEquals([firstStep routeType], RESIDENTIAL, @"Route steps not being calculated");
    STAssertEquals([highwayStep routeType], HIGHWAY, @"Route steps not being calculated");
}

- (void)testParsingDirectionsReturnsNULLWhenJSONInvalid{
    NSMutableData *invalidJSON = [NSMutableData dataWithBytes:@"jfls" length:10];
    NSArray *steps = [GoogleJSONParser parseDirectionsJSON:invalidJSON];
    STAssertNil(steps, @"Should return NULL when invalid json");
}

- (void)testParsingDirectionsReturnsNULLWhenResponseStatusIsBad{
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"bad_status_response" ofType:@"json"];
    NSMutableData *badResponseData = [NSMutableData dataWithContentsOfFile:filePath];

    NSArray *places = [GoogleJSONParser parseDirectionsJSON:badResponseData];
    STAssertNil(places, @"Should return NULL when invalid json");
}


@end
