#import <Foundation/Foundation.h>
#import "RoutePoint.h"
#import "GoogleRoute.h"

@protocol GoogleDirectionsConnectionDelegate;

@interface GoogleDirectionsConnection : NSObject
@property (nonatomic, weak) id <GoogleDirectionsConnectionDelegate> delegate;

-(id)initWithDelegate:(id <GoogleDirectionsConnectionDelegate>)del;
-(void)getGoogleDirectionsFrom:(NSString *)origin to:(NSString *)destination;

@end

@protocol GoogleDirectionsConnectionDelegate
- (void) didFinishLoadingWithGoogleRoute:(GoogleRoute *)optimizedRoutes;
- (void) errorOccurred;
@end
