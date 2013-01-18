//
//  GoogleJSONParser.m
//  FindOnTheWay
//
//  Created by jyaunche on 1/17/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "GoogleJSONParser.h"
#import "GooglePlacesObject.h"
#import "GoogleRoute.h"

@implementation GoogleJSONParser

+ (NSArray *)parsePlacesJSON:(NSMutableData *)data {

    NSError *jsonError = nil;
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingMutableLeaves
                                                                 error:&jsonError];
    NSMutableArray *googlePlacesObjects = [NSMutableArray array];
    if ([jsonError code] == 0) {
        NSString *responseStatus = [NSString stringWithFormat:@"%@", [parsedJSON objectForKey:@"status"]];

        if ([responseStatus isEqualToString:@"OK"]) {
            //Perform Place Search results
            NSDictionary *gResponseData = [parsedJSON objectForKey:@"results"];
            CLLocation *location = [[CLLocation alloc] initWithLatitude:39.29038 longitude:-76.61219];

            for (NSDictionary *result in gResponseData) {
                GooglePlacesObject *object = [[GooglePlacesObject alloc] initWithJsonResultDict:result andUserCoordinates:location.coordinate];
                [googlePlacesObjects addObject:object];
            }

        }else{
            NSLog(@"Bad response retrieving places from google: status was %@", responseStatus);
            return NULL;
        }
    }else{
        NSLog(@"Error retrieving places from google: json error code retrieved was %@", jsonError);
        return NULL;
    }

    return googlePlacesObjects;
}

+ (NSArray *)parseDirectionsJSON:(NSMutableData *)data {
    NSError *jsonError = nil;
    NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:data
                                                               options:NSJSONReadingMutableLeaves
                                                                 error:&jsonError];

    if ([jsonError code] == 0) {
        NSString *responseStatus = [NSString stringWithFormat:@"%@", [parsedJSON objectForKey:@"status"]];

        if ([responseStatus isEqualToString:@"OK"]) {
            NSArray *route = [parsedJSON objectForKey:@"routes"];
            NSArray *legs = [[route objectAtIndex:0] objectForKey:@"legs"];
            NSArray *steps = [[legs objectAtIndex:0] objectForKey:@"steps"];

            NSMutableArray *allSteps = [NSMutableArray array];

            for (NSDictionary *stepJson in steps){
                NSString *meter = [[stepJson objectForKey:@"distance"] objectForKey:@"value"];
                RoutePoint *startLocation = [self buildPoint:[stepJson objectForKey:@"start_location"]];
                RoutePoint *endLocation = [self buildPoint:[stepJson objectForKey:@"end_location"]];

                RouteStepType type = RESIDENTIAL;
                NSArray *highwayWords = [NSArray arrayWithObjects:@"Interstate", @"Expressway", @"Toll road", @"Parial toll road", @"Parkway", nil];
                for (NSString * word in highwayWords){
                    if ([[stepJson objectForKey:@"html_instructions"] rangeOfString:word].location != NSNotFound) {
                        type = HIGHWAY;
                    }
                }

                [allSteps addObject:[BasicRouteStep initWithStart:startLocation
                                                       andWithEnd:endLocation
                                          andWithDistanceInMeters:meter.floatValue
                                                      andWithType:type]];
            }

            return allSteps;
        }
        else{
            NSLog(@"Bad response retrieving directions from google: status was %@", responseStatus);
            return NULL;
        }
    }
    else {
        NSLog(@"Error retrieving directions from google: json error code retrieved was %@", jsonError);
        return NULL;
    }
}

+ (RoutePoint *)buildPoint:(NSDictionary *)locationJson {
    NSString *startLatitude = [locationJson objectForKey:@"lat"];
    NSString *startLongitude = [locationJson objectForKey:@"lng"];
    return [RoutePoint initWithLatitude:startLatitude.floatValue longitude:startLongitude.floatValue];
}
@end
