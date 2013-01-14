#import "RouteMapViewController.h"
#import "GoogleDirectionsConnection.h"

@interface RouteMapViewController ()

@end

@implementation RouteMapViewController

@synthesize map = _map;
@synthesize stepsToShow = _stepsToShow;

- (void)viewDidLoad
{
    [super viewDidLoad];
    for (RouteStep *step in self.stepsToShow){
        [self.map addAnnotation:step.startLocation];
        [self.map addAnnotation:step.endLocation];
    }

}

//- (void) didFinishLoadingWithGoogleRoute:(GoogleRoute *)optimizedRoutes{
//    for (RouteStep *step in optimizedRoutes.steps){
//        [self.map addAnnotation:step.startLocation];
//        [self.map addAnnotation:step.endLocation];
//    }
//}
//
//- (void) noResultsFound{
//    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Places Found"
//                                                      message:@"There seems to be network issues!"
//                                                     delegate:nil
//                                            cancelButtonTitle:@"OK"
//                                            otherButtonTitles:nil];
//    [message show];
//}


@end
