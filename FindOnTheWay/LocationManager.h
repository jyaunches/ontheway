#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class AvailableFestivalFetcher;

@protocol LocationManagerDelegate <NSObject>
-(void) locationRetrieved:(NSString *)latitude andLongitude:(NSString *)longitude;
-(void) couldNotRetrieveLocation;
@end

@interface LocationManager : NSObject <CLLocationManagerDelegate> {
    id <LocationManagerDelegate> delegate;
}

+ (LocationManager *) goFestLocationManager;

@property (nonatomic,assign) id<LocationManagerDelegate> delegate;
@property (nonatomic, strong) CLLocationManager *locationManager;
- (void)beginLocationManagement;
@end
