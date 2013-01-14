#import "GoogleRouteTest.h"
#import "RouteStep.h"
#import "GoogleRoute.h"


@implementation GoogleRouteTest
@synthesize firstStepStart = _firstStepStart;
@synthesize firstStepEnd = _firstStepEnd;
@synthesize middleStepEnd = _middleStepEnd;
@synthesize finalStepEnd = _finalStepEnd;
@synthesize firstStep = _firstStep;
@synthesize middleStep = _middleStep;
@synthesize finalStep = _finalStep;

//- (void)setUp
//{
//    [super setUp];
//    self.firstStepStart = [Location initWithLatitude:39.86810000000001 andWithLongitude:-4.029400000000001];
//    self.firstStepEnd = [Location initWithLatitude:39.862810 andWithLongitude:-4.027390];
//    self.middleStepEnd = [Location initWithLatitude:39.867530 andWithLongitude:-4.027580];
//    self.finalStepEnd = [Location initWithLatitude:39.86886000000001 andWithLongitude:-4.021520000000001];
//
//    self.firstStep = [RouteStep initWithStart:self.firstStepStart andWithEnd:self.firstStepEnd andWithDistanceInMeters:600];
//    self.middleStep = [RouteStep initWithStart:self.firstStepEnd andWithEnd:self.middleStepEnd andWithDistanceInMeters:200];
//    self.finalStep = [RouteStep initWithStart:self.middleStepEnd andWithEnd:self.finalStepEnd andWithDistanceInMeters:600];
//}
//
//- (void)tearDown
//{
//    [super tearDown];
//}
//
//- (void)testMostDirectDistance
//{
//    GoogleRoute *route = [GoogleRoute initWithSteps:[NSArray arrayWithObjects:self.firstStep, self.middleStep, nil]];
//    NSNumber *mostDirectDistance = [NSNumber numberWithDouble:[route mostDirectDistance]];
//    NSNumber *expectedDistance = [NSNumber numberWithDouble:0.6324555555944804];
//
//    STAssertEqualObjects(mostDirectDistance, expectedDistance, @"The distances don't match!");
//}
//
//- (void)testMostDirectDistanceWithManySteps
//{
//    GoogleRoute *route = [GoogleRoute initWithSteps:[NSArray arrayWithObjects:self.firstStep, self.middleStep, self.finalStep, nil]];
//    NSNumber *mostDirectDistance = [NSNumber numberWithDouble:[route mostDirectDistance]];
//    NSNumber *expectedDistance = [NSNumber numberWithDouble:0.8485281711413358];
//
//    STAssertEqualObjects(mostDirectDistance, expectedDistance, @"The distances don't match!");
//}
//
//- (void)testSignificantRoutesExcludeThoseWhereDistanceIsLessThanHalfOfAverage
//{
//    GoogleRoute *route = [GoogleRoute initWithSteps:[NSArray arrayWithObjects:self.firstStep, self.middleStep, self.finalStep, nil]];
//
//    NSArray *expectedRoutes = [NSArray arrayWithObjects:self.firstStep, self.finalStep, nil];
//    STAssertEqualObjects(route.significantSteps, expectedRoutes, @"The distances don't match!");
//}
//


@end

