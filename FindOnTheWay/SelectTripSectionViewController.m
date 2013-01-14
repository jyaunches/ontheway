//
//  SelectTripSectionViewController.m
//  FindOnTheWay
//
//  Created by Julietta Yaunches on 1/14/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import "SelectTripSectionViewController.h"
#import "RouteMapViewController.h"
#import "MBProgressHUD.h"

@implementation SelectTripSectionViewController
@synthesize optimizedGoogleRoute = _optimizedGoogleRoute;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RouteMapViewController *mapViewController = [segue destinationViewController];

    if([[segue identifier] isEqualToString:@"ShowBeginningSection"]) {
        mapViewController.stepsToShow = self.optimizedGoogleRoute.beginningSteps;
    }else if ([[segue identifier] isEqualToString:@"ShowMiddleSection"]) {
        mapViewController.stepsToShow = self.optimizedGoogleRoute.middleSteps;
    }else if ([[segue identifier] isEqualToString:@"ShowEndSection"]) {
        mapViewController.stepsToShow = self.optimizedGoogleRoute.endSteps;
    }
}

- (void)showHUD {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Looking for your directions!";
}

- (void) didFinishLoadingWithGoogleRoute:(GoogleRoute *)optimizedRoutes{
    self.optimizedGoogleRoute = optimizedRoutes;
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
@end
