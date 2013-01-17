//
//  GoogleJSONParser.h
//  FindOnTheWay
//
//  Created by jyaunche on 1/17/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoogleJSONParser : NSObject
+ (NSArray *)parsePlacesJSON:(NSMutableData *)data;

+ (NSArray *)parseDirectionsJSON:(NSMutableData *)data;
@end
