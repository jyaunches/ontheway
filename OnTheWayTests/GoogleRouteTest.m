#import "GoogleRouteTest.h"
#import "RouteStep.h"
#import "Location.h"
#import "GoogleRoute.h"

@implementation GoogleRouteTest
- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testMostDirectDistance
{
    Location *step1_start = [Location initWithLatitude:39.86810000000001 andWithLongitude:-4.029400000000001];
    Location *step1_end = [Location initWithLatitude:39.862810 andWithLongitude:-4.027390];

    Location *step2_end = [Location initWithLatitude:39.867530 andWithLongitude:-4.027580];

    RouteStep *step1 = [RouteStep initWithStart:step1_start andWithEnd:step1_end andWithDistance:0.6];
    RouteStep *step2 = [RouteStep initWithStart:step1_end andWithEnd:step2_end andWithDistance:0.2];

    GoogleRoute *route = [[GoogleRoute alloc] initWithSteps:[NSArray arrayWithObjects:step1, step2]];

    double mostDirectDistance = [route mostDirectDistance];

    STAssertEquals(0.4, mostDirectDistance, @"The name does not match");}

@end
