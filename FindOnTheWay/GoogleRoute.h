#import <Foundation/Foundation.h>
#import "BasicRouteStep.h"

@interface GoogleRoute : NSObject
@property(nonatomic, readonly) NSArray *steps;

+ (id)initWithSteps:(NSArray *)steps;
- (NSArray *)pointsToSearchForPlaces;
@end
