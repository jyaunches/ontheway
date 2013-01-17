#import "RouteOptimizer.h"

@implementation RouteOptimizer

+ (NSArray *)optimizedRoutes:(NSArray *)steps {
    NSMutableArray *significantRoutes = [NSMutableArray array];
    float cumulativeDistance = 0;
    NSEnumerator *stepEnumerator = [steps objectEnumerator];
    NSMutableArray *cumulativeSteps = [NSMutableArray arrayWithCapacity:steps.count];

    BasicRouteStep *nextStep;
    while (nextStep = [stepEnumerator nextObject]) {

        RouteStepType lastCumulativeStepRouteType = ((BasicRouteStep *) cumulativeSteps.lastObject).routeType;
        BOOL movingFromHighwayToResidential = lastCumulativeStepRouteType != nextStep.routeType;
        BOOL isNotFirstStep = lastCumulativeStepRouteType != UNASSIGNED;
        BOOL isHighway = lastCumulativeStepRouteType == HIGHWAY;
        if ((movingFromHighwayToResidential && isNotFirstStep) || isHighway){
            [significantRoutes addObject:[CumulativeRouteStep initWithSteps:cumulativeSteps]];
            cumulativeDistance = 0;
            [cumulativeSteps removeAllObjects];
        }

        [cumulativeSteps addObject:nextStep];
        cumulativeDistance += nextStep.distanceInMeter;
    }
    [significantRoutes addObject:[CumulativeRouteStep initWithSteps:cumulativeSteps]];

    return significantRoutes;
}

+ (BOOL)isLastStep:(BasicRouteStep *)nextStep forSteps:(NSArray *)allSteps {
    return ([allSteps indexOfObject:nextStep] == (allSteps.count - 1));
}

+ (BOOL)distanceIsLargeEnough:(float)distance givenAverage:(double)averageDistance {
    return distance >= (averageDistance/2);
}

+ (double)averageDistance:(NSArray *)steps {
    double totalDistance = 0.0;
    for (BasicRouteStep *step in steps){ totalDistance += step.distanceInMeter; }

    return totalDistance / steps.count;
}
@end
