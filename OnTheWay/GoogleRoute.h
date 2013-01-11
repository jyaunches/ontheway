#import <Foundation/Foundation.h>

@interface GoogleRoute : NSObject
- (id)initWithSteps:(NSArray *)steps;

- (double)mostDirectDistance;
@end
