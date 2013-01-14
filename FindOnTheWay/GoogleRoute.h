#import <Foundation/Foundation.h>
#import "RouteStep.h"

@interface GoogleRoute : NSObject
@property(nonatomic, readonly) NSArray *steps;

+ (id)initWithSteps:(NSArray *)steps;

- (RouteStep *)firstStep;
- (RouteStep *)finalStep;

- (NSArray *)beginningSteps;
- (NSArray *)middleSteps;
- (NSArray *)endSteps;

@end
