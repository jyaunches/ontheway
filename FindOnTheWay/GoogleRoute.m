#import "GoogleRoute.h"
#import "BasicRouteStep.h"

@interface GoogleRoute ()
@property(nonatomic, readwrite) NSArray *steps;
@end

@implementation GoogleRoute
@synthesize steps = _steps;

+ (id)initWithSteps:(NSArray *)steps {
    GoogleRoute *route = [[GoogleRoute alloc] init];
    route.steps = steps;
    return route;
}

- (NSArray *)pointsToSearchForPlaces {
    NSMutableArray *points = [NSMutableArray array];
    for (CumulativeRouteStep *step in self.steps){
        [points addObjectsFromArray:step.pointsToSearchForPlaces];
    }
    return [points arrayByAddingObjectsFromArray:points];
}
@end
