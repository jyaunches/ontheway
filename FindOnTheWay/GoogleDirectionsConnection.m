#import "GoogleDirectionsConnection.h"
#import "RouteOptimizer.h"
#import "GoogleRoute.h"
#import "GoogleJSONParser.h"

@interface GoogleDirectionsConnection ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation GoogleDirectionsConnection

@synthesize delegate;

- (id)initWithDelegate:(id <GoogleDirectionsConnectionDelegate>)del
{
    self = [super init];
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

- (void)connectionDidFinishLoading:(NSURLConnection *)conn {

    NSArray *directions = [GoogleJSONParser parseDirectionsJSON:self.responseData];

    if (directions == NULL){
        [delegate errorOccurred];
    }else{
        [delegate didFinishLoadingWithGoogleRoute:directions];
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
