#import <MapKit/MapKit.h>
#import "RouteMapViewController.h"
#import "GoogleDirectionsConnection.h"
#import "GooglePlacesObject.h"

@implementation RouteMapViewController

@synthesize map = _map;
@synthesize stepsToShow = _stepsToShow;

- (void)viewDidLoad
{
    [super viewDidLoad];
    googlePlacesConnection = [[GooglePlacesConnection alloc] initWithDelegate:self];
    BasicRouteStep *o = [_stepsToShow objectAtIndex:0];
    RoutePoint *midPoint = [o midPoint];
    [googlePlacesConnection getGoogleObjects:midPoint forRadius:1000];
}

- (void) googlePlacesConnection:(GooglePlacesConnection *)conn didFinishLoadingWithGooglePlacesObjects:(NSMutableArray *)objects{
    for (GooglePlacesObject *place in objects){
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(place.coordinate, 5000, 5000);
        [self.map setRegion:region animated:NO];

        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = place.coordinate;
        annotationPoint.title = place.name;
        [self.map addAnnotation:annotationPoint];
    }
}

- (void) noResultsFound{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Places Found"
                                                  message:@"There seems to be network issues!"
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
    [message show];
}

- (void) errorOccurred{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Places Found"
                                                  message:@"There seems to be network issues!"
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
    [message show];
}

//- (void) didFinishLoadingWithGoogleRoute:(GoogleRoute *)optimizedRoutes{
//    for (BasicRouteStep *step in optimizedRoutes.steps){
//        [self.map addAnnotation:step.startLocation];
//        [self.map addAnnotation:step.endLocation];
//    }
//}

@end
