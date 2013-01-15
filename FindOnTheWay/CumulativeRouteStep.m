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

- (float)distanceInMeters{
    float result = 0;
    for (BasicRouteStep *step in self.steps){
        result += step.distanceInMeter;
    }
    return result;
}
@end
