#import "RouteOptimizerTest.h"
#import "CumulativeRouteStep.h"
#import "GoogleRoute.h"
#import "RouteOptimizer.h"

@implementation RouteOptimizerTest 

@synthesize brooklynStart = _brooklynStart;
@synthesize step1End = _step1End;
@synthesize step2End = _step2End;
@synthesize step3End = _step3End;
@synthesize step4End = _step4End;
@synthesize step5End = _step5End;
@synthesize step6End = _step6End;
@synthesize step7End = _step7End;
@synthesize step8End = _step8End;
@synthesize step9End = _step9End;
@synthesize forestParkEnd = _forestParkEnd;
@synthesize residentialStep1 = _residentialStep1;
@synthesize residentialStep2 = _residentialStep2;
@synthesize residentialStep3 = _residentialStep3;
@synthesize highwayStep1 = _highwayStep1;
@synthesize highwayStep3 = _highwayStep3;
@synthesize highwayStep2 = _highwayStep2;
@synthesize highwayStep4 = _highwayStep4;
@synthesize residentialStep4 = _residentialStep4;
@synthesize residentialStep5 = _residentialStep5;
@synthesize residentialStep6 = _residentialStep6;


- (void)setUp
{
    [super setUp];
    self.brooklynStart = [RoutePoint initWithLatitude:40.649750f longitude:-73.949980f];
    self.step1End = [RoutePoint initWithLatitude:40.699970f longitude:-73.949480f];
    self.step2End = [RoutePoint initWithLatitude:40.648910f longitude:-73.949380f];
    self.step3End = [RoutePoint initWithLatitude:40.64910f longitude:-73.94650f];
    self.step4End = [RoutePoint initWithLatitude:40.652780f longitude:-73.94690f];
    self.step5End = [RoutePoint initWithLatitude:40.658560f longitude:-73.89053000000001f];
    self.step6End = [RoutePoint initWithLatitude:40.67825000000001f longitude:-73.89741000000001f];
    self.step7End = [RoutePoint initWithLatitude:40.697620f longitude:-73.87068000000001f];
    self.step8End = [RoutePoint initWithLatitude:40.697240f longitude:-73.869230f];
    self.step9End = [RoutePoint initWithLatitude:40.696320f longitude:-73.86651000000001f];
    self.forestParkEnd = [RoutePoint initWithLatitude:40.699970f longitude:-73.85658000000001f];

    self.residentialStep1 = [BasicRouteStep initWithStart:self.brooklynStart andWithEnd:self.brooklynStart andWithDistanceInMeters:43 andWithType:RESIDENTIAL];
    self.residentialStep2 = [BasicRouteStep initWithStart:self.step1End andWithEnd:self.step2End andWithDistanceInMeters:96 andWithType:RESIDENTIAL];
    self.residentialStep3 = [BasicRouteStep initWithStart:self.step2End andWithEnd:self.step3End andWithDistanceInMeters:243 andWithType:RESIDENTIAL];
    self.highwayStep1 = [BasicRouteStep initWithStart:self.step3End andWithEnd:self.step4End andWithDistanceInMeters:411 andWithType:HIGHWAY];
    self.highwayStep2 = [BasicRouteStep initWithStart:self.step4End andWithEnd:self.step5End andWithDistanceInMeters:4903 andWithType:HIGHWAY];
    self.highwayStep3 = [BasicRouteStep initWithStart:self.step5End andWithEnd:self.step6End andWithDistanceInMeters:2289 andWithType:HIGHWAY];
    self.highwayStep4 = [BasicRouteStep initWithStart:self.step6End andWithEnd:self.step7End andWithDistanceInMeters:3431 andWithType:HIGHWAY];
    self.residentialStep4 = [BasicRouteStep initWithStart:self.step7End andWithEnd:self.step8End andWithDistanceInMeters:137 andWithType:RESIDENTIAL];
    self.residentialStep5 = [BasicRouteStep initWithStart:self.step8End andWithEnd:self.step9End andWithDistanceInMeters:277 andWithType:RESIDENTIAL];
    self.residentialStep6 = [BasicRouteStep initWithStart:self.step9End andWithEnd:self.forestParkEnd andWithDistanceInMeters:1105 andWithType:RESIDENTIAL];
}

- (void)testOptimizerShouldCumulateFirstStepUntilHittingHighway
{
    GoogleRoute *route = [GoogleRoute initWithSteps:[NSArray arrayWithObjects:self.residentialStep1, self.residentialStep2, self.residentialStep3, self.highwayStep1, self.highwayStep2, nil]];

    NSArray *optimizedSteps = [RouteOptimizer optimizedRoutes:route.steps];
    CumulativeRouteStep *firstStep = [optimizedSteps objectAtIndex:0];

    STAssertEquals(firstStep.startLocation.latitude, self.brooklynStart.latitude, @"First route step start location inaccurate");
    STAssertEquals(firstStep.endLocation.latitude, self.step3End.latitude, @"First route step end location inaccurate");

    float expectedDistance = 382;
    STAssertEquals(firstStep.distanceInMeters, expectedDistance, @"Actual distance was %f", firstStep.distanceInMeters);
}

-(void)testShouldHaveHighwayStepsAsIndividualOptimizedSteps{
    GoogleRoute *route = [GoogleRoute initWithSteps:[NSArray arrayWithObjects:self.highwayStep1, self.highwayStep2, self.residentialStep4, self.residentialStep5, nil]];

    NSArray *optimizedSteps = [RouteOptimizer optimizedRoutes:route.steps];

    STAssertTrue((optimizedSteps.count == 3), @"There were actually %i", optimizedSteps.count);

    CumulativeRouteStep *firstStep = [optimizedSteps objectAtIndex:0];
    CumulativeRouteStep *secondStep = [optimizedSteps objectAtIndex:1];
    CumulativeRouteStep *thirdStep = [optimizedSteps objectAtIndex:2];

    STAssertEquals(firstStep.routeType, HIGHWAY, @"First route step start location inaccurate");
    STAssertEquals(secondStep.routeType, HIGHWAY, @"First route step start location inaccurate");
    STAssertEquals(thirdStep.routeType, RESIDENTIAL, @"First route step start location inaccurate");
}

- (void)testOptimizerShouldCreateRoutesBasedOnAverageDistanceOfSteps
{
    GoogleRoute *route = [GoogleRoute initWithSteps:[NSArray arrayWithObjects:self.residentialStep1, self.residentialStep2, self.residentialStep3, self.highwayStep1, self.highwayStep2,
                                                                              self.highwayStep3, self.highwayStep4, self.residentialStep4, self.residentialStep5, self.residentialStep6, nil]];

    NSArray *optimizedSteps = [RouteOptimizer optimizedRoutes:route.steps];
    STAssertTrue((optimizedSteps.count == 6), @"There were actually %i", optimizedSteps.count);
}


@end
