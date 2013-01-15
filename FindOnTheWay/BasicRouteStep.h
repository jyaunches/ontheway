#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "RoutePoint.h"


@interface BasicRouteStep : NSObject

@property(nonatomic, readwrite) RoutePoint *endLocation;
@property(nonatomic, readwrite) RoutePoint *startLocation;
@property(nonatomic, readwrite) float distanceInMeter;

+ (id)initWithStart:(RoutePoint *)startLocation andWithEnd:(RoutePoint *)endLocation andWithDistanceInMeters:(float)distanceInMeter;
- (RoutePoint *)midPoint;
@end