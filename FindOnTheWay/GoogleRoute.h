#import <Foundation/Foundation.h>
#import "BasicRouteStep.h"

@interface GoogleRoute : NSObject
@property(nonatomic, readonly) NSArray *steps;

+ (id)initWithSteps:(NSArray *)steps;

- (BasicRouteStep *)firstStep;
- (BasicRouteStep *)finalStep;

- (NSArray *)beginningSteps;
- (NSArray *)middleSteps;
- (NSArray *)endSteps;

- (NSArray *)pointsToSearchForPlaces;
@end
