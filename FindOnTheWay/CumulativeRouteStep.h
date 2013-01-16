//
//  CumulativeRouteStep.h
//  FindOnTheWay
//
//  Created by Julietta Yaunches on 1/15/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RoutePoint;

typedef enum {UNASSIGNED, RESIDENTIAL, HIGHWAY} RouteStepType;

@interface CumulativeRouteStep : NSObject

@property(nonatomic, copy) NSMutableArray *steps;

+ (id)initWithSteps:(NSMutableArray *)cumulativeSteps;
- (RoutePoint *)startLocation;
- (RoutePoint *)endLocation;
- (float)distanceInMeters;
- (RouteStepType)routeType;

- (NSArray *)pointsToSearchForPlaces;
@end
