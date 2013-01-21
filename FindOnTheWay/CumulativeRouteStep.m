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

- (RoutePoint *)startLocation {
    return [[self.steps objectAtIndex:0] startLocation];
}

- (RoutePoint *)endLocation {
    return [[self.steps lastObject] endLocation];
}

- (RouteStepType)routeType {
    return [[self.steps objectAtIndex:0] routeType];
}

- (float)distanceInMeters {
    float result = 0;
    for (BasicRouteStep *step in self.steps) {
        result += step.distanceInMeter;
    }
    return result;
}

- (NSArray *)pointsToSearchForPlaces {
    NSMutableArray *points = [NSMutableArray array];


    for (BasicRouteStep *step in self.steps) {
        if (step.distanceInMeter >= HALFMILE) {

            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setMaximumFractionDigits:1];
            [formatter setRoundingMode:NSNumberFormatterRoundDown];

            int numberPointsNeeded = ceil(step.distanceInMeter / SIXMILES);

            float startLat = self.startLocation.latitude;
            float startLng = self.startLocation.longitude;

            float distanceBetweenPointsLat = [self getDouble:numberPointsNeeded startVal:startLat difference:[[self endLocation] latitude]];
            float distanceBetweenPointsLng = [self getDouble:numberPointsNeeded startVal:startLng difference:[[self endLocation] longitude]];

            for (int index = 0; index < numberPointsNeeded; index++) {
                startLat += distanceBetweenPointsLat;
                startLng += distanceBetweenPointsLng;

                RoutePoint *point = [RoutePoint initWithLatitude:startLat longitude:startLng];
                [points addObject:point];
            }
        }
    }
    return points;
}

- (float)getDouble:(int)numberPointsNeeded
          startVal:(float)startVal
        difference:(float)endVal {
    float result = endVal - startVal;
    return result / (numberPointsNeeded + 1);
}
@end
