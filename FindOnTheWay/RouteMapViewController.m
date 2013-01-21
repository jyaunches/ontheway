#import <MapKit/MapKit.h>
#import "RouteMapViewController.h"
#import "GoogleDirectionsConnection.h"
#import "GooglePlacesObject.h"
#import "MBProgressHUD.h"
#import "RouteOptimizer.h"

@implementation RouteMapViewController {
@private NSUInteger routePointIndex;
}


@synthesize map = _map;
@synthesize optimizedRoute = _optimizedRoute;
@synthesize routePointIndex = _routePointIndex;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showHUD];
}

- (void)didFinishLoadingWithGoogleRoute:(NSArray *)basicRouteSteps {
    NSArray *optimizedSteps = [RouteOptimizer optimizedRoutes:basicRouteSteps];
    self.optimizedRoute = [GoogleRoute initWithSteps:optimizedSteps];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.routePointIndex = 0;
    RoutePoint *point = [[self.optimizedRoute pointsToSearchForPlaces] objectAtIndex:self.routePointIndex];

    googlePlacesConnection = [[GooglePlacesConnection alloc] initWithDelegate:self];
    [googlePlacesConnection getGoogleObjects:point forRadius:2000];
}

- (void)showHUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Looking for your directions!";
}
- (IBAction)viewNextClicked:(id)sender {
    
}

- (void)didFinishLoadingWithGooglePlacesObjects:(NSMutableArray *)objects {
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
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Network Problems"
                                                  message:@"We're having trouble retrieving info for your trip."
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
    [message show];
}

@end
