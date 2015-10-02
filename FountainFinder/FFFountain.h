//
//  FFFountain.h
//  FountainFinder
//
//  Created by Spencer Phippen on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface FFFountain : NSObject <MKAnnotation>

- (instancetype) initWithDictionary:(NSDictionary*)dict;
- (NSDictionary*) dictionaryVersion;

@property (nonatomic, copy) NSString* title;
@property int temperature;
@property int pressure;
@property int cleanliness;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
