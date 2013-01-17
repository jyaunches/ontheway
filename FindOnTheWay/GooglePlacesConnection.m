#import <CoreLocation/CoreLocation.h>
#import "GooglePlacesConnection.h"
#import "GooglePlacesObject.h"
#import "GoogleJSONParser.h"

@interface GooglePlacesConnection ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation GooglePlacesConnection

@synthesize delegate;

- (id)initWithDelegate:(id <GooglePlacesConnectionDelegate>)del
{
    self = [super init];
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

- (void)connectionDidFinishLoading:(NSURLConnection *)conn {
    NSArray *places = [GoogleJSONParser parsePlacesJSON:self.responseData];

    if (places == NULL){
        [delegate errorOccurred];
    }else{
        [delegate didFinishLoadingWithGooglePlacesObjects:places];
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

@end
