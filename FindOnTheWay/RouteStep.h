#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "RoutePoint.h"


@interface RouteStep : NSObject

@property(nonatomic, readwrite) RoutePoint *endLocation;
@property(nonatomic, readwrite) RoutePoint *startLocation;
@property(nonatomic, readwrite) float distanceInMeter;

+ (id)initWithStart:(RoutePoint *)startLocation andWithEnd:(RoutePoint *)endLocation andWithDistanceInMeters:(float)distanceInMeter;
@end