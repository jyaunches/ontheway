#import "RouteInputViewController.h"
#import "RouteMapViewController.h"

@implementation RouteInputViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowRouteMapSegue"]) {
        RouteMapViewController *routeMapVC = [segue destinationViewController];

        if (googleDirectionsConnection == nil){
            googleDirectionsConnection = [[GoogleDirectionsConnection alloc] initWithDelegate:routeMapVC];
        }
        [googleDirectionsConnection getGoogleDirectionsFrom:@"200 Schermerhorn St. Brooklyn NY" to:@"115 N Luzerne Ave. Baltimore MD"];
    }
}

@end
