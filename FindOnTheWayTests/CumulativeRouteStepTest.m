//
//  CumulativeRouteStepTest.m
//  FindOnTheWay
//
//  Created by Julietta Yaunches on 1/15/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import "CumulativeRouteStepTest.h"
#import "CumulativeRouteStep.h"
#import "BasicRouteStep.h"

@implementation CumulativeRouteStepTest

- (void)setUp
{
    [super setUp];
    self.someStartLocation = [RoutePoint initWithLatitude:40.6497 longitude:-67.3456];
    self.someEndLocation = [RoutePoint initWithLatitude:40.6597 longitude:-68.3456];
}

-(void)testShouldGiveOnePointWhenStepsTotalLessThan2Miles{
    BasicRouteStep *halfMileStep = [BasicRouteStep initWithStart:self.someStartLocation andWithEnd:self.someEndLocation andWithDistanceInMeters:805 andWithType:RESIDENTIAL];
    BasicRouteStep *thirdMileStep = [BasicRouteStep initWithStart:self.someStartLocation andWithEnd:self.someEndLocation andWithDistanceInMeters:537 andWithType:RESIDENTIAL];

    NSMutableArray *steps = [NSMutableArray arrayWithObjects:halfMileStep, thirdMileStep, nil];
    CumulativeRouteStep *cumulativeRouteStep = [CumulativeRouteStep initWithSteps:steps];

    NSArray *pointsToSearch = [cumulativeRouteStep pointsToSearchForPlaces];
    STAssertTrue((pointsToSearch.count == 1), @"Actual value is %i", pointsToSearch.count);
}

-(void)testShouldGiveOnePointForEachStepOver2Miles{
    BasicRouteStep *halfMileStep = [BasicRouteStep initWithStart:self.someStartLocation andWithEnd:self.someEndLocation andWithDistanceInMeters:805 andWithType:RESIDENTIAL];
    BasicRouteStep *thirdMileStep = [BasicRouteStep initWithStart:self.someStartLocation andWithEnd:self.someEndLocation andWithDistanceInMeters:537 andWithType:RESIDENTIAL];
    BasicRouteStep *twoMileStep = [BasicRouteStep initWithStart:self.someStartLocation andWithEnd:self.someEndLocation andWithDistanceInMeters:3500 andWithType:HIGHWAY];

    NSMutableArray *steps = [NSMutableArray arrayWithObjects:halfMileStep, thirdMileStep, twoMileStep, nil];
    CumulativeRouteStep *cumulativeRouteStep = [CumulativeRouteStep initWithSteps:steps];

    NSArray *pointsToSearch = [cumulativeRouteStep pointsToSearchForPlaces];
    STAssertTrue((pointsToSearch.count == 2), @"Actual value is %i", pointsToSearch.count);
    float finalPointLongitude = ((RoutePoint *) [pointsToSearch objectAtIndex:1]).longitude;
    STAssertEquals(finalPointLongitude, -67.845596f, @"Route point longitude: %f", finalPointLongitude);
}

@end
