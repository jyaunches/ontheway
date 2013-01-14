#import "OnTheWayTestCase.h"

@class Location;
@class RouteStep;

@interface GoogleRouteTest : OnTheWayTestCase
@property(nonatomic, strong) Location *firstStepStart;
@property(nonatomic, strong) Location *firstStepEnd;
@property(nonatomic, strong) Location *middleStepEnd;
@property(nonatomic, strong) Location *finalStepEnd;
@property(nonatomic, strong) RouteStep *firstStep;
@property(nonatomic, strong) RouteStep *middleStep;
@property(nonatomic, strong) RouteStep *finalStep;
@end
