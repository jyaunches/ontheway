#import "GoogleRoute.h"

@interface RouteOptimizer : NSObject
+ (NSArray *)optimizedRoutes:(NSArray *)steps;
+ (GoogleRoute *)fromJSON:(NSDictionary *)route;
@end
