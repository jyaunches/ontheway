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


- (void)viewDidLoad{
    [super viewDidLoad];
    [self showHUD];
    googlePlacesConnection = [[GooglePlacesConnection alloc] initWithDelegate:self];
    self.routePointIndex = 0;
}

- (void)didFinishLoadingWithGoogleRoute:(NSArray *)basicRouteSteps {
    self.optimizedRoute = [GoogleRoute initWithSteps:[RouteOptimizer optimizedRoutes:basicRouteSteps]];
    [self searchPlacesForPoint];
}

- (void)searchPlacesForPoint {
    RoutePoint *point = [[self.optimizedRoute pointsToSearchForPlaces] objectAtIndex:self.routePointIndex];
    [googlePlacesConnection getGoogleObjects:point forRadius:2000];
    self.routePointIndex++;
}

- (IBAction)viewNextClicked:(id)sender {
    [self showHUD];
    [self searchPlacesForPoint];
}

- (void)didFinishLoadingWithGooglePlacesObjects:(NSMutableArray *)objects {
    [self hideHUD];

    for (GooglePlacesObject *place in objects){
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(place.coordinate, 5000, 5000);
        [self.map setRegion:region animated:NO];

        MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
        annotationPoint.coordinate = place.coordinate;
        annotationPoint.title = place.name;
        [self.map addAnnotation:annotationPoint];
    }
}

- (void)showHUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Looking for your directions!";
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
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
