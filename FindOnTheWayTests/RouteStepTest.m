//
//  RouteStepTest.m
//  FindOnTheWay
//
//  Created by Julietta Yaunches on 1/15/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import "RouteStepTest.h"
#import "BasicRouteStep.h"

@implementation RouteStepTest

-(void)testShouldCalculateMidPointBetweenStartAndEnd{
    RoutePoint *startPoint = [RoutePoint initWithLatitude:39.87 longitude:-4.02];
    RoutePoint *endPoint = [RoutePoint initWithLatitude:39.70 longitude:-3.87];
    BasicRouteStep *step = [BasicRouteStep initWithStart:startPoint andWithEnd:endPoint andWithDistanceInMeters:4000 andWithType:RESIDENTIAL];

    RoutePoint *midPoint = step.midPoint;
    STAssertEquals(midPoint.latitude, 39.785000f, @"Not calculating latitude");
    STAssertEquals(midPoint.longitude , -3.945000f, @"Not calculating longitude");
}

@end
