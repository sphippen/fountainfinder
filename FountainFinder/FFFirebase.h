//
//  FFFirebase.h
//  FountainFinder
//
//  Created by Andy Soto on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase/Firebase.h>
#import "FFFountain.h"

@interface FFFirebase : NSObject

+ (Firebase*) f;

+ (NSArray*) fountains;
+ (void) addFountain:(FFFountain*)fountain;

+ (void) listenForFountains;

@end

extern NSString* const FFFirebaseFountainsChanged;