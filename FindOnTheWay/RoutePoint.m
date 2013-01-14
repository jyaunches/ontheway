#import <CoreLocation/CoreLocation.h>
#import "RoutePoint.h"

@implementation RoutePoint
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize coordinate = _coordinate;

+ (id)initWithLatitude:(float)latitude longitude:(float)longitude {
    RoutePoint *point = [[RoutePoint alloc] init];
    point.latitude = latitude;
    point.longitude = longitude;
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    point.coordinate = coordinate;


    return point;
}

- (NSString *)title {
    return [NSString stringWithFormat:@"Lat:%f     Long:%f", self.latitude, self.longitude];
}

- (NSString *)subtitle {
    return @"Subtitle";
}

@end
