#import <Foundation/Foundation.h>

@class Location;

@interface RouteStep : NSObject
@property(nonatomic, readonly) float distanceInKm;

+ (id)initWithStart:(Location *)startLocation andWithEnd:(Location *)endLocation andWithDistance:(float)distanceInKm;
@end