#import "OnTheWayTestCase.h"

@implementation OnTheWayTestCase
BOOL arrayContains(NSArray *array, id toMatch) {
    for (id item in array){
        if (item == toMatch){
            return YES;
        }
    }
    return NO;
}
@end
