#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GooglePlacesConnection.h"

@interface RouteMapViewController : UIViewController<MKMapViewDelegate, GooglePlacesConnectionDelegate>{
    GooglePlacesConnection  *googlePlacesConnection;
}
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property(nonatomic, strong) id stepsToShow;
@end
