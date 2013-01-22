#import "RouteInputViewController.h"
#import "RouteMapViewController.h"

@implementation RouteInputViewController

@synthesize origin = _origin;
@synthesize destination = _destination;
@synthesize searchField = _searchField;

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
        [googleDirectionsConnection getGoogleDirectionsFrom:self.origin.text to:self.destination.text];
    }
}

@end
