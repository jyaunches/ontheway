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

-(void)testShouldGiveOnePointForEachStepOver2MilesAndUnder4Miles{
    BasicRouteStep *halfMileStep = [BasicRouteStep initWithStart:self.someStartLocation andWithEnd:self.someEndLocation andWithDistanceInMeters:805 andWithType:RESIDENTIAL];
    BasicRouteStep *thirdMileStep = [BasicRouteStep initWithStart:self.someStartLocation andWithEnd:self.someEndLocation andWithDistanceInMeters:537 andWithType:RESIDENTIAL];

    RoutePoint *someOtherEndLocation = [RoutePoint initWithLatitude:40.6597 longitude:-70.3456];

    BasicRouteStep *twoMileStep = [BasicRouteStep initWithStart:self.someStartLocation andWithEnd:someOtherEndLocation andWithDistanceInMeters:3500 andWithType:HIGHWAY];

    NSMutableArray *steps = [NSMutableArray arrayWithObjects:halfMileStep, thirdMileStep, twoMileStep, nil];
    CumulativeRouteStep *cumulativeRouteStep = [CumulativeRouteStep initWithSteps:steps];

    NSArray *pointsToSearch = [cumulativeRouteStep pointsToSearchForPlaces];
    STAssertTrue((pointsToSearch.count == 2), @"Actual value is %i", pointsToSearch.count);
    float finalPointLongitude = ((RoutePoint *) [pointsToSearch objectAtIndex:1]).longitude;
    STAssertEquals(finalPointLongitude, -68.845596f, @"Route point longitude: %f", finalPointLongitude);
}

-(void)testShouldGiveMultiplePointsWhenStepIsMoreThan5Miles{
    BasicRouteStep *sixMileStep = [BasicRouteStep initWithStart:self.someStartLocation andWithEnd:self.someEndLocation andWithDistanceInMeters:9700 andWithType:HIGHWAY];

    NSMutableArray *steps = [NSMutableArray arrayWithObjects:sixMileStep, nil];
    CumulativeRouteStep *cumulativeRouteStep = [CumulativeRouteStep initWithSteps:steps];

    NSArray *pointsToSearch = [cumulativeRouteStep pointsToSearchForPlaces];
    STAssertTrue((pointsToSearch.count == 2), @"Actual value is %i", pointsToSearch.count);
}

-(void)testShouldPointForEachSixMileLegInLargeStep{
    BasicRouteStep *fortyMileStep = [BasicRouteStep initWithStart:self.someStartLocation andWithEnd:self.someEndLocation andWithDistanceInMeters:65000 andWithType:HIGHWAY];

    NSMutableArray *steps = [NSMutableArray arrayWithObjects:fortyMileStep, nil];
    CumulativeRouteStep *cumulativeRouteStep = [CumulativeRouteStep initWithSteps:steps];

    NSArray *pointsToSearch = [cumulativeRouteStep pointsToSearchForPlaces];
    STAssertTrue((pointsToSearch.count == 7), @"Actual value is %i", pointsToSearch.count);
}

-(void)testShouldHandleMovingToALowerLatitude{
    RoutePoint *higherLatitudePoint = [RoutePoint initWithLatitude:40.6597 longitude:-70.3456];
    RoutePoint *lowerLatitudePoint = [RoutePoint initWithLatitude:38.6597 longitude:-70.3456];

    BasicRouteStep *movingSouthStep = [BasicRouteStep initWithStart:higherLatitudePoint andWithEnd:lowerLatitudePoint andWithDistanceInMeters:4000 andWithType:RESIDENTIAL];

    CumulativeRouteStep *cumulativeRouteStep = [CumulativeRouteStep initWithSteps:[NSMutableArray arrayWithObjects:movingSouthStep, nil]];

    RoutePoint *point = [[cumulativeRouteStep pointsToSearchForPlaces] objectAtIndex:0];

    STAssertEquals(point.latitude, 39.6597f, @"Actual value was %@", point.latitude);
}

-(void)testShouldHandleMovingToAHigherLatitude{
    RoutePoint *higherLatitudePoint = [RoutePoint initWithLatitude:40.6597 longitude:-70.3456];
    RoutePoint *lowerLatitudePoint = [RoutePoint initWithLatitude:38.6597 longitude:-70.3456];

    BasicRouteStep *movingSouthStep = [BasicRouteStep initWithStart:lowerLatitudePoint andWithEnd:higherLatitudePoint andWithDistanceInMeters:4000 andWithType:RESIDENTIAL];

    CumulativeRouteStep *cumulativeRouteStep = [CumulativeRouteStep initWithSteps:[NSMutableArray arrayWithObjects:movingSouthStep, nil]];

    RoutePoint *point = [[cumulativeRouteStep pointsToSearchForPlaces] objectAtIndex:0];

    STAssertEquals(point.latitude, 39.6597f, @"Actual value was %@", point.latitude);
}

-(void)testShouldHandleMovingToALowerLongitude{
    RoutePoint *higherLongitudePoint = [RoutePoint initWithLatitude:40.6597 longitude:-75.3856];
    RoutePoint *lowerLongitudePoint = [RoutePoint initWithLatitude:40.6597 longitude:-70.6456];

    BasicRouteStep *movingSouthStep = [BasicRouteStep initWithStart:higherLongitudePoint andWithEnd:lowerLongitudePoint andWithDistanceInMeters:4000 andWithType:RESIDENTIAL];

    CumulativeRouteStep *cumulativeRouteStep = [CumulativeRouteStep initWithSteps:[NSMutableArray arrayWithObjects:movingSouthStep, nil]];

    RoutePoint *point = [[cumulativeRouteStep pointsToSearchForPlaces] objectAtIndex:0];

    STAssertEquals(point.longitude, -73.015594f, @"Actual value was %@", point.latitude);
}

-(void)testShouldHandleMovingToAHigherLongitude{
    RoutePoint *higherLongitudePoint = [RoutePoint initWithLatitude:40.6597 longitude:-74.4486];
    RoutePoint *lowerLongitudePoint = [RoutePoint initWithLatitude:40.6597 longitude:-70.7056];

    BasicRouteStep *movingSouthStep = [BasicRouteStep initWithStart:lowerLongitudePoint andWithEnd:higherLongitudePoint andWithDistanceInMeters:4000 andWithType:RESIDENTIAL];

    CumulativeRouteStep *cumulativeRouteStep = [CumulativeRouteStep initWithSteps:[NSMutableArray arrayWithObjects:movingSouthStep, nil]];

    RoutePoint *point = [[cumulativeRouteStep pointsToSearchForPlaces] objectAtIndex:0];

    STAssertEquals(point.longitude, -72.5771f, @"Actual value was %@", point.latitude);
}

@end
