//
//  CumulativeRouteStepTest.h
//  FindOnTheWay
//
//  Created by Julietta Yaunches on 1/15/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OnTheWayTestCase.h"

@class RoutePoint;

@interface CumulativeRouteStepTest : OnTheWayTestCase

@property(nonatomic, strong) RoutePoint *someStartLocation;
@property(nonatomic, strong) RoutePoint *someEndLocation;
@end
