#import "RouteOptimizer.h"
#import "CumulativeRouteStep.h"

@implementation RouteOptimizer

+ (NSArray *)optimizedRoutes:(NSArray *)steps {
    NSMutableArray *significantRoutes = [NSMutableArray array];
    double avgDist = [self averageDistance:steps];

    float cumulativeDistance = 0;
    NSEnumerator *stepEnumerator = [steps objectEnumerator];
    NSMutableArray *cumulativeSteps = [NSMutableArray arrayWithCapacity:steps.count];

    BasicRouteStep *nextStep;
    while (nextStep = [stepEnumerator nextObject]) {
        cumulativeDistance += nextStep.distanceInMeter;
        [cumulativeSteps addObject:nextStep];

        BOOL distanceIsBigEnough = [self distanceIsLargeEnough:[nextStep distanceInMeter] givenAverage:avgDist];
        BOOL cumulativeIsBigEnough = [self distanceIsLargeEnough:cumulativeDistance givenAverage:avgDist];
        BOOL isLastStep = [self isLastStep:nextStep forSteps:steps];

        if (distanceIsBigEnough || cumulativeIsBigEnough || isLastStep){
            [significantRoutes addObject:[CumulativeRouteStep initWithSteps:cumulativeSteps]];
            cumulativeDistance = 0;
            [cumulativeSteps removeAllObjects];
        }
    }

    return significantRoutes;
}

+ (BOOL)isLastStep:(BasicRouteStep *)nextStep forSteps:(NSArray *)allSteps {
    return ([allSteps indexOfObject:nextStep] == (allSteps.count - 1));
}

+ (BOOL)distanceIsLargeEnough:(float)distance givenAverage:(double)averageDistance {
    return distance >= (averageDistance/2);
}

+ (GoogleRoute *)fromJSON:(NSDictionary *)routeAsJSON {
    NSArray *route = [routeAsJSON objectForKey:@"routes"];
    NSArray *legs = [[route objectAtIndex:0] objectForKey:@"legs"];
    NSArray *steps = [[legs objectAtIndex:0] objectForKey:@"steps"];

    NSMutableArray *allSteps = [NSMutableArray array];

    for (NSDictionary *stepJson in steps){
        NSString *meter = [[stepJson objectForKey:@"distance"] objectForKey:@"value"];
        RoutePoint *startLocation = [self buildPoint:[stepJson objectForKey:@"start_location"]];
        RoutePoint *endLocation = [self buildPoint:[stepJson objectForKey:@"end_location"]];

        [allSteps addObject:[BasicRouteStep initWithStart:startLocation andWithEnd:endLocation andWithDistanceInMeters:meter.floatValue]];
    }

    return [GoogleRoute initWithSteps:[self optimizedRoutes:allSteps]];
}

+ (RoutePoint *)buildPoint:(NSDictionary *)locationJson {
    NSString *startLatitude = [locationJson objectForKey:@"lat"];
    NSString *startLongitude = [locationJson objectForKey:@"lng"];
    return [RoutePoint initWithLatitude:startLatitude.floatValue longitude:startLongitude.floatValue];
}

+ (double)averageDistance:(NSArray *)steps {
    double totalDistance = 0.0;
    for (BasicRouteStep *step in steps){ totalDistance += step.distanceInMeter; }

    return totalDistance / steps.count;
}
@end
