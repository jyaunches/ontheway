#import "RouteOptimizerTest.h"
#import "RouteStep.h"
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
@synthesize step1 = _step1;
@synthesize step2 = _step2;
@synthesize step3 = _step3;
@synthesize step4 = _step4;
@synthesize step6 = _step6;
@synthesize step5 = _step5;
@synthesize step7 = _step7;
@synthesize step8 = _step8;
@synthesize step9 = _step9;
@synthesize step10 = _step10;


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

    self.step1 = [RouteStep initWithStart:self.brooklynStart andWithEnd:self.brooklynStart andWithDistanceInMeters:43];
    self.step2 = [RouteStep initWithStart:self.step1End andWithEnd:self.step2End andWithDistanceInMeters:96];
    self.step3 = [RouteStep initWithStart:self.step2End andWithEnd:self.step3End andWithDistanceInMeters:243];
    self.step4 = [RouteStep initWithStart:self.step3End andWithEnd:self.step4End andWithDistanceInMeters:411];
    self.step5 = [RouteStep initWithStart:self.step4End andWithEnd:self.step5End andWithDistanceInMeters:4903];
    self.step6 = [RouteStep initWithStart:self.step5End andWithEnd:self.step6End andWithDistanceInMeters:2289];
    self.step7 = [RouteStep initWithStart:self.step6End andWithEnd:self.step7End andWithDistanceInMeters:3431];
    self.step8 = [RouteStep initWithStart:self.step7End andWithEnd:self.step8End andWithDistanceInMeters:137];
    self.step9 = [RouteStep initWithStart:self.step8End andWithEnd:self.step9End andWithDistanceInMeters:277];
    self.step10 = [RouteStep initWithStart:self.step9End andWithEnd:self.forestParkEnd andWithDistanceInMeters:1105];
}

- (void)testOptimizerShouldCumulateDistanceOverMultipleSmallerRoutes
{
    GoogleRoute *route = [GoogleRoute initWithSteps:[NSArray arrayWithObjects:self.step1, self.step2, self.step3, self.step4, self.step5, nil]];

    NSArray *optimizedSteps = [RouteOptimizer optimizedRoutes:route];
    RouteStep *firstStep = [optimizedSteps objectAtIndex:0];

    STAssertEquals(firstStep.startLocation.latitude, self.brooklynStart.latitude, @"First route step start location inaccurate");
    STAssertEquals(firstStep.endLocation.latitude, self.step4End.latitude, @"First route step end location inaccurate");

    float expectedDistance = 793;
    STAssertEquals(firstStep.distanceInMeter, expectedDistance, @"Step should cumulate distances of smaller steps before it");
}

- (void)testOptimizerShouldCreateRoutesBasedOnAverageDistanceOfSteps
{
    GoogleRoute *route = [GoogleRoute initWithSteps:[NSArray arrayWithObjects:self.step1, self.step2, self.step3, self.step4, self.step5,
                                                                              self.step6, self.step7, self.step8, self.step9, self.step10, nil]];

    NSArray *optimizedSteps = [RouteOptimizer optimizedRoutes:route];
    STAssertTrue((optimizedSteps.count == 5), @"Should only be 5 steps");
}

- (void)testOptimizerUseStartingPointOfFirstNodeConsideredAndEndPointOfLastNodeWhereDistanceIsLongEnough
{
    GoogleRoute *route = [GoogleRoute initWithSteps:[NSArray arrayWithObjects:self.step1, self.step2, self.step3, self.step4, self.step5,
                                                                              self.step6, self.step7, self.step8, self.step9, self.step10, nil]];

    NSArray *optimizedSteps = [RouteOptimizer optimizedRoutes:route];

    RouteStep *secondStep = [optimizedSteps objectAtIndex:1];
    RouteStep *thirdStep = [optimizedSteps objectAtIndex:2];
    RouteStep *fourthStep = [optimizedSteps objectAtIndex:3];
    RouteStep *fifthStep = [optimizedSteps lastObject];

    STAssertEquals(secondStep.startLocation.latitude, self.step4End.latitude, @"Second route step start location inaccurate");
    STAssertEquals(secondStep.endLocation.latitude, self.step5End.latitude, @"Second route step end location inaccurate");

    STAssertEquals(thirdStep.startLocation.latitude, self.step5End.latitude, @"Second route step start location inaccurate");
    STAssertEquals(thirdStep.endLocation.latitude, self.step6End.latitude, @"Second route step end location inaccurate");

    STAssertEquals(fourthStep.startLocation.latitude, self.step6End.latitude, @"Second route step start location inaccurate");
    STAssertEquals(fourthStep.endLocation.latitude, self.step7End.latitude, @"Second route step end location inaccurate");

    STAssertEquals(fifthStep.startLocation.latitude, self.step7End.latitude, @"Second route step start location inaccurate");
    STAssertEquals(fifthStep.endLocation.latitude, self.forestParkEnd.latitude, @"Second route step end location inaccurate");
}

- (void)testParsingFromJSON{
    NSError *fileError = nil;
    NSString *filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"brooklyn_to_forest_hill" ofType:@"json"];
    NSString *directionsJSONResult = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:&fileError];

    NSData *data = [directionsJSONResult dataUsingEncoding:NSUTF8StringEncoding];

    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingMutableLeaves
                                                                 error:nil];

    GoogleRoute *route = [RouteOptimizer fromJSON:parsedJSON];
    RouteStep *fifthStep = [route.steps lastObject];

    STAssertTrue((route.steps.count == 5), @"Should only be 5 steps");
    STAssertEquals(fifthStep.endLocation.latitude, 40.699970f, @"Route steps not being calculated");
}


@end
