#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface RoutePoint : NSObject <MKAnnotation>

@property(nonatomic, readwrite) float latitude;
@property(nonatomic, readwrite) float longitude;
@property(nonatomic, readwrite) CLLocationCoordinate2D coordinate;

+ (id)initWithLatitude:(float)latitude longitude:(float)longitude;
@end
