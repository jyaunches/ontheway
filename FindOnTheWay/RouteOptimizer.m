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

+ (GoogleRoute *)fromJSON:(NSDictionary *)routeAsJSON {
    NSArray *route = [routeAsJSON objectForKey:@"routes"];
    NSArray *legs = [[route objectAtIndex:0] objectForKey:@"legs"];
    NSArray *steps = [[legs objectAtIndex:0] objectForKey:@"steps"];

    NSMutableArray *allSteps = [NSMutableArray array];

    for (NSDictionary *stepJson in steps){
        NSString *meter = [[stepJson objectForKey:@"distance"] objectForKey:@"value"];
        RoutePoint *startLocation = [self buildPoint:[stepJson objectForKey:@"start_location"]];
        RoutePoint *endLocation = [self buildPoint:[stepJson objectForKey:@"end_location"]];

        RouteStepType type = RESIDENTIAL;
        NSArray *highwayWords = [NSArray arrayWithObjects:@"Interstate", @"Expressway", @"Toll road", @"Parial toll road", @"Parkway", nil];
        for (NSString * word in highwayWords){
            if ([[stepJson objectForKey:@"html_instructions"] rangeOfString:word].location != NSNotFound) {
                type = HIGHWAY;
            }
        }

        [allSteps addObject:[BasicRouteStep initWithStart:startLocation
                                               andWithEnd:endLocation
                                  andWithDistanceInMeters:meter.floatValue
                                              andWithType:type]];
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
