#import "GoogleRoute.h"
#import "BasicRouteStep.h"

@interface GoogleRoute ()
@property(nonatomic, readwrite) NSArray *steps;
@end

@implementation GoogleRoute
@synthesize steps = _steps;

+ (id)initWithSteps:(NSArray *)steps {
    GoogleRoute *route = [[GoogleRoute alloc] init];
    route.steps = steps;
    return route;
}

- (double) mostDirectDistance {
    double step1Squared = pow([[self.steps objectAtIndex:0] distanceInMeter], 2.0);
    double finalStepSquared = pow([self.finalStep distanceInMeter], 2.0);

    return sqrt(step1Squared + finalStepSquared);
}

- (NSArray *)beginningSteps{
    return [NSArray arrayWithObjects:[self.steps objectAtIndex:0], nil];
}

- (NSArray *)middleSteps{
    NSRange rangeForView = NSMakeRange(1, ([self.steps count] - 1));
    return [self.steps subarrayWithRange:rangeForView];
}

- (NSArray *)endSteps{
    return [NSArray arrayWithObjects:self.steps.lastObject, nil];
}

- (BasicRouteStep *)firstStep{
    return [self.steps objectAtIndex:0];
}

- (BasicRouteStep *)finalStep{
    return [self.steps lastObject];
}

@end
