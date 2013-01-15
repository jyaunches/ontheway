#import <Foundation/Foundation.h>
#import "RoutePoint.h"

@protocol GooglePlacesConnectionDelegate;

@interface GooglePlacesConnection : NSObject
@property (nonatomic, weak) id <GooglePlacesConnectionDelegate> delegate;

- (id)initWithDelegate:(id <GooglePlacesConnectionDelegate>)del;

-(void)getGoogleObjects:(RoutePoint *)routePoint
               forRadius:(int)radius;

@end


@protocol GooglePlacesConnectionDelegate

- (void) googlePlacesConnection:(GooglePlacesConnection *)conn didFinishLoadingWithGooglePlacesObjects:(NSMutableArray *)objects;
- (void) noResultsFound;
- (void) errorOccurred;

@end
