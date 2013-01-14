#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RouteMapViewController : UIViewController<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property(nonatomic, strong) id stepsToShow;
@end
