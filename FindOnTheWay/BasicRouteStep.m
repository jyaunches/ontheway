#import "BasicRouteStep.h"

@implementation BasicRouteStep

@synthesize endLocation = _endLocation;
@synthesize startLocation = _startLocation;
@synthesize distanceInMeter = _distanceInMeter;
@synthesize routeType = _routeType;

+ (id)initWithStart:(RoutePoint *)startLocation andWithEnd:(RoutePoint *)endLocation andWithDistanceInMeters:(float)distanceInMeter andWithType:(RouteStepType)type{
    BasicRouteStep *step = [[BasicRouteStep alloc] init];
    
    step.startLocation = startLocation;
    step.endLocation = endLocation;
    step.distanceInMeter = distanceInMeter;
    step.routeType = type;

    return step;
}

- (RoutePoint *)midPoint{
    float lat = (self.startLocation.latitude + self.endLocation.latitude) / 2;
    float lng = (self.startLocation.longitude + self.endLocation.longitude) / 2;
    return [RoutePoint initWithLatitude:lat longitude:lng];
}
@end