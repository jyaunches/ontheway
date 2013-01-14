#import "RouteInputViewController.h"
#import "SelectTripSectionViewController.h"

@implementation RouteInputViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SelectTripSegmentSegue"]) {
        SelectTripSectionViewController *selectTripVC = [segue destinationViewController];
        [selectTripVC showHUD];

        googleDirectionsConnection = [[GoogleDirectionsConnection alloc] initWithDelegate:selectTripVC];
        [googleDirectionsConnection getGoogleDirectionsFrom:@"200 Schermerhorn St. Brooklyn NY" to:@"115 N Luzerne Ave. Baltimore MD"];
    }
}

@end
