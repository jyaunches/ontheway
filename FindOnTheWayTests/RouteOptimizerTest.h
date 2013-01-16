#import "OnTheWayTestCase.h"

@class RoutePoint;
@class BasicRouteStep;

@interface RouteOptimizerTest : OnTheWayTestCase

@property(nonatomic, strong) RoutePoint *brooklynStart;
@property(nonatomic, strong) RoutePoint *step1End;
@property(nonatomic, strong) RoutePoint *step2End;
@property(nonatomic, strong) RoutePoint *step3End;
@property(nonatomic, strong) RoutePoint *step4End;
@property(nonatomic, strong) RoutePoint *step5End;
@property(nonatomic, strong) RoutePoint *step6End;
@property(nonatomic, strong) RoutePoint *step7End;
@property(nonatomic, strong) RoutePoint *step8End;
@property(nonatomic, strong) RoutePoint *step9End;
@property(nonatomic, strong) RoutePoint *forestParkEnd;
@property(nonatomic, strong) BasicRouteStep *residentialStep1;
@property(nonatomic, strong) BasicRouteStep *residentialStep2;
@property(nonatomic, strong) BasicRouteStep *residentialStep3;
@property(nonatomic, strong) BasicRouteStep *highwayStep1;
@property(nonatomic, strong) BasicRouteStep *highwayStep3;
@property(nonatomic, strong) BasicRouteStep *highwayStep2;
@property(nonatomic, strong) BasicRouteStep *highwayStep4;
@property(nonatomic, strong) BasicRouteStep *residentialStep4;
@property(nonatomic, strong) BasicRouteStep *residentialStep5;
@property(nonatomic, strong) BasicRouteStep *residentialStep6;
@end
