#import "GoogleDirectionsConnection.h"
#import "RouteOptimizer.h"
#import "GoogleRoute.h"

@interface GoogleDirectionsConnection ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation GoogleDirectionsConnection

@synthesize delegate;

- (id)initWithDelegate:(id <GoogleDirectionsConnectionDelegate>)del
{
    self = [super init];

    if (!self)
        return nil;
    [self setDelegate:del];
    return self;
}

-(void)getGoogleDirectionsFrom:(NSString *)origin to:(NSString *)destination {
    self.responseData = [NSMutableData data];

    NSString *escapedOrigin = [origin stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *escapedDestination = [destination stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];


    NSString *gurl = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=true",
                                                escapedOrigin, escapedDestination];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:gurl]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10];

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];

    if (!connection) {
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
            GoogleRoute *googleRoute = [RouteOptimizer fromJSON:parsedJSON];
            [delegate didFinishLoadingWithGoogleRoute:googleRoute];
        }
    }
    else {
        //log json error
        [delegate errorOccurred];
    }
}

@end
