//
//  CumulativeRouteStep.m
//  FindOnTheWay
//
//  Created by Julietta Yaunches on 1/15/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import "CumulativeRouteStep.h"
#import "RoutePoint.h"
#import "BasicRouteStep.h"

@implementation CumulativeRouteStep
@synthesize steps = _steps;

+ (id)initWithSteps:(NSMutableArray *)cumulativeSteps {
    CumulativeRouteStep *cumulativeRouteStep = [[CumulativeRouteStep alloc] init];
    cumulativeRouteStep.steps = cumulativeSteps;
    return cumulativeRouteStep;
}

- (RoutePoint *)startLocation{
    return [[self.steps objectAtIndex:0] startLocation];
}

- (RoutePoint *)endLocation{
    return [[self.steps lastObject] endLocation];
}

- (RouteStepType)routeType{
    return [[self.steps objectAtIndex:0] routeType];
}

- (float)distanceInMeters{
    float result = 0;
    for (BasicRouteStep *step in self.steps){
        result += step.distanceInMeter;
    }
    return result;
}

- (NSArray *)pointsToSearchForPlaces {
    float lat = ([[self startLocation] latitude] + [[self endLocation] latitude]) / 2;
    float lng = ([[self startLocation] longitude] + [[self endLocation] longitude]) / 2;

    return [NSArray arrayWithObjects:[RoutePoint initWithLatitude:lat longitude:lng], nil];
}
@end
