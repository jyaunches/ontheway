#import "LocationManager.h"

@interface LocationManager ()
@property (nonatomic, strong) NSString *location;
@end

@implementation LocationManager
@synthesize locationManager = _locationManager;
@synthesize delegate = _delegate;

+ (LocationManager *) goFestLocationManager{
    static LocationManager *goFestLocationManager = nil;
    if(!goFestLocationManager)
        goFestLocationManager = [[LocationManager alloc] init];
    
    return goFestLocationManager;
}

- (void)locationManager:(CLLocationManager *) manager
     didUpdateLocations:(NSArray *)locations{
    
    NSString *lat = [[NSString alloc] init];
    NSString *lng = [[NSString alloc] init];
    for(CLLocation* location in locations){
        lat = [[NSString alloc] initWithFormat:@"%g",location.coordinate.latitude];
        lng = [[NSString alloc] initWithFormat:@"%g", location.coordinate.longitude];
    }
    [self.locationManager stopUpdatingLocation];
    [self.delegate locationRetrieved:lat andLongitude:lng];
}

- (void)locationManager:(CLLocationManager *) manager didFailWithError:(NSError *)error{
    NSLog(@"no location info!!");
    [self.delegate couldNotRetrieveLocation];
}

- (void)beginLocationManagement{
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
    [self.locationManager setDelegate:self];
    [self.locationManager startUpdatingLocation];
}

@end
