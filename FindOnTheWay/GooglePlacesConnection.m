#import <CoreLocation/CoreLocation.h>
#import "GooglePlacesConnection.h"
#import "GooglePlacesObject.h"

@interface GooglePlacesConnection ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation GooglePlacesConnection

@synthesize delegate;

- (id)initWithDelegate:(id <GooglePlacesConnectionDelegate>)del
{
    self = [super init];

    if (!self)
        return nil;
    [self setDelegate:del];
    return self;
}

- (void)getGoogleObjects:(RoutePoint *)routePoint
               forRadius:(int)radius {

    double centerLat = routePoint.latitude;
    double centerLng = routePoint.longitude;

    NSString *gurl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&name=dunkin&radius=%i&sensor=true&key=%@",
                                                centerLat, centerLng, radius, @"AIzaSyB8OGiyvP9vjZ9qRunlhjR9-wigWAq_R70"];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:gurl]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10];


    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];

    if (connection) {
        self.responseData = [NSMutableData data];
    }
    else {
        NSLog(@"connection failed");
    }
}

- (void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)conn didFailWithError:(NSError *)error {
    //log error
    [delegate errorOccurred];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn {

    NSError *jsonError = nil;
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                        options:NSJSONReadingMutableLeaves
                                                          error:&jsonError];

    if ([jsonError code] == 0) {
        NSString *responseStatus = [NSString stringWithFormat:@"%@", [parsedJSON objectForKey:@"status"]];

        if ([responseStatus isEqualToString:@"OK"]) {
            //Perform Place Search results
            NSDictionary *gResponseData = [parsedJSON objectForKey:@"results"];
            NSMutableArray *googlePlacesObjects = [NSMutableArray arrayWithCapacity:[[parsedJSON objectForKey:@"results"] count]];

            for (NSDictionary *result in gResponseData) {
                [googlePlacesObjects addObject:result];
            }

            for (int x = 0; x < [googlePlacesObjects count]; x++) {
                CLLocation *location = [[CLLocation alloc] initWithLatitude:39.29038 longitude:-76.61219];
                GooglePlacesObject *object = [[GooglePlacesObject alloc] initWithJsonResultDict:[googlePlacesObjects objectAtIndex:x] andUserCoordinates:location.coordinate];
                [googlePlacesObjects replaceObjectAtIndex:x withObject:object];
            }

            [delegate googlePlacesConnection:self didFinishLoadingWithGooglePlacesObjects:googlePlacesObjects];
        }
        else {
            //log no results
            [delegate noResultsFound];
        }
    }
    else {
        //log json error
        [delegate errorOccurred];
    }
}

@end
