#import "GoogleRoute.h"
#import "math.h"
#import "RouteStep.h"

@interface GoogleRoute ()
@property(nonatomic, readwrite) NSArray *steps;
@end

@implementation GoogleRoute
@synthesize steps = _steps;

- (id)initWithSteps:(NSArray *)steps {
    GoogleRoute *route = [[GoogleRoute alloc] init];
    route.steps = steps;
}

- (double)mostDirectDistance {
    double step1Squared = pow([[self.steps objectAtIndex:0] distanceInKm], 2.0);
    double finalStepSquared = pow([[self.steps objectAtIndex:[self.steps count]] distanceInKm], 2.0);

    return sqrt(step1Squared + finalStepSquared);
}
@end
