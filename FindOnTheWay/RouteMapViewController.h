#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GooglePlacesConnection.h"
#import "GoogleDirectionsConnection.h"

@interface RouteMapViewController : UIViewController<MKMapViewDelegate, GoogleDirectionsConnectionDelegate, GooglePlacesConnectionDelegate>{
    GooglePlacesConnection  *googlePlacesConnection;
    GoogleDirectionsConnection  *googleDirectionsConnection;
}
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property(nonatomic, strong) GoogleRoute *optimizedRoute;
@property(nonatomic) int routePointIndex;
@end
