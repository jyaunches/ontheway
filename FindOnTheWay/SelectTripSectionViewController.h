//
//  SelectTripSectionViewController.h
//  FindOnTheWay
//
//  Created by Julietta Yaunches on 1/14/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleDirectionsConnection.h"

@interface SelectTripSectionViewController : UIViewController<GoogleDirectionsConnectionDelegate>

@property(nonatomic, strong) GoogleRoute *optimizedGoogleRoute;

- (void)showHUD;
@end
