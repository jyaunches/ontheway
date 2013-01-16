//
//  CumulativeRouteStepTest.m
//  FindOnTheWay
//
//  Created by Julietta Yaunches on 1/15/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import <OCMock/OCMock.h>
#import "CumulativeRouteStepTest.h"
#import "CumulativeRouteStep.h"
#import "BasicRouteStep.h"

@implementation CumulativeRouteStepTest

-(void)testShouldGiveOnePointWhenStepsTotalLessThan2Miles{
    RoutePoint *firstStepStartLocation = [RoutePoint initWithLatitude:40.6497 longitude:-67.3456];
    RoutePoint *firstStepEndLocation = [RoutePoint initWithLatitude:40.6597 longitude:-68.3456];
    BasicRouteStep *halfMileStep = [BasicRouteStep initWithStart:firstStepStartLocation andWithEnd:firstStepEndLocation andWithDistanceInMeters:805 andWithType:RESIDENTIAL];

    RoutePoint *secondStepStartLocation = [RoutePoint initWithLatitude:40.6497 longitude:-67.3456];
    RoutePoint *secondStepEndLocation = [RoutePoint initWithLatitude:40.6597 longitude:-68.3456];
    BasicRouteStep *thirdMileStep = [BasicRouteStep initWithStart:secondStepStartLocation andWithEnd:secondStepEndLocation andWithDistanceInMeters:537 andWithType:RESIDENTIAL];

    NSMutableArray *steps = [NSMutableArray arrayWithObjects:halfMileStep, thirdMileStep, nil];
    CumulativeRouteStep *cumulativeRouteStep = [CumulativeRouteStep initWithSteps:steps];

    NSArray *pointsToSearch = [cumulativeRouteStep pointsToSearchForPlaces];
    STAssertTrue((pointsToSearch.count == 1), @"Actual value is %i", pointsToSearch.count);
}

@end
