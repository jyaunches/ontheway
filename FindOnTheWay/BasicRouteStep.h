#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "RoutePoint.h"
#import "CumulativeRouteStep.h"


@interface BasicRouteStep : NSObject

@property(nonatomic, readwrite) RoutePoint *endLocation;
@property(nonatomic, readwrite) RoutePoint *startLocation;
@property(nonatomic, readwrite) float distanceInMeter;
@property(nonatomic) RouteStepType routeType;


+ (id)initWithStart:(RoutePoint *)startLocation andWithEnd:(RoutePoint *)endLocation andWithDistanceInMeters:(float)distanceInMeter andWithType:(RouteStepType)type;
- (RoutePoint *)midPoint;
@end