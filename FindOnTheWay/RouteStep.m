#import "RouteStep.h"
#import "RoutePoint.h"

@implementation RouteStep

@synthesize endLocation = _endLocation;
@synthesize startLocation = _startLocation;
@synthesize distanceInMeter = _distanceInMeter;

+ (id)initWithStart:(RoutePoint *)startLocation andWithEnd:(RoutePoint *)endLocation andWithDistanceInMeters:(float)distanceInMeter {
    RouteStep *step = [[RouteStep alloc] init];
    
    step.startLocation = startLocation;
    step.endLocation = endLocation;
    step.distanceInMeter = distanceInMeter;

    return step;
}
@end