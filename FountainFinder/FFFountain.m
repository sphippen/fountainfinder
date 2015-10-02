//
//  FFFountain.m
//  FountainFinder
//
//  Created by Andy Soto on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import "FFFountain.h"

@implementation FFFountain

- (instancetype) initWithDictionary:(NSDictionary*)dict {
    self = [super init];

    [self setTitle:[dict objectForKey:@"title"]];
    [self setTemperature:[[dict objectForKey:@"temperature"] intValue]];
    [self setPressure:[[dict objectForKey:@"pressure"] intValue]];
    [self setCleanliness:[[dict objectForKey:@"cleanliness"] intValue]];

    CLLocationCoordinate2D loc;
    loc.latitude = [[dict objectForKey:@"latitude"] doubleValue];
    loc.longitude = [[dict objectForKey:@"longitude"] doubleValue];
    [self setCoordinate:loc];

    return self;
}

- (NSDictionary*) dictionaryVersion {
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:[self title] forKey:@"title"];
    [dict setObject:[NSNumber numberWithInt:[self temperature]] forKey:@"temperature"];
    [dict setObject:[NSNumber numberWithInt:[self pressure]] forKey:@"pressure"];
    [dict setObject:[NSNumber numberWithInt:[self cleanliness]] forKey:@"cleanliness"];
    [dict setObject:[NSNumber numberWithDouble:[self coordinate].latitude] forKey:@"latitude"];
    [dict setObject:[NSNumber numberWithDouble:[self coordinate].longitude] forKey:@"longitude"];

    return dict;
}

@end
