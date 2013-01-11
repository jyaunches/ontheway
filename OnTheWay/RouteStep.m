#import "RouteStep.h"
#import "Location.h"

@interface RouteStep()
@property(nonatomic, readwrite) Location *end;
@property(nonatomic, readwrite) Location *start;
@property(nonatomic, readwrite) float distanceInKm;

@end

@implementation RouteStep

@synthesize end = _end;
@synthesize start = _start;
@synthesize distanceInKm = _distanceInKm;


+ (id)initWithStart:(Location *)startLocation andWithEnd:(Location *)endLocation andWithDistance:(float)distanceInKm {
    RouteStep *step = [[RouteStep alloc] init];
    
    step.start = startLocation;
    step.end = endLocation;
    step.distanceInKm = distanceInKm;
}
@end