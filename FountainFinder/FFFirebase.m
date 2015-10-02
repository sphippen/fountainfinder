//
//  FFFirebase.m
//  FountainFinder
//
//  Created by Spencer Phippen on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import "FFFirebase.h"

static NSArray* sFountains = nil;

@implementation FFFirebase

+ (Firebase*) f {
    static Firebase* f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        f = [[Firebase alloc] initWithUrl:@"https://blinding-torch-5882.firebaseio.com/"];
    });
    return f;
}

+ (Firebase*) fountainsPath {
    return [[self f] childByAppendingPath:@"fountains"];
}

+ (void) listenForFountains {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self fountainsPath] observeEventType:(FEventTypeValue) withBlock:^(FDataSnapshot *snapshot) {
            NSMutableArray* fountains = [NSMutableArray new];
            NSDictionary* fountsMap = [snapshot value];
            for (NSString* dictKey in fountsMap)
                [fountains addObject:[[FFFountain alloc] initWithDictionary:[fountsMap objectForKey:dictKey]]];

            sFountains = fountains;
            [[NSNotificationCenter defaultCenter] postNotificationName:FFFirebaseFountainsChanged object:nil];
            NSLog(@"Fountains updated: %ld fountains", (long)[sFountains count]);
        }];
    });
}

+ (NSArray*) fountains {
    return sFountains;
}

+ (void) addFountain:(FFFountain*)fountain {
    Firebase* newFountain = [[self fountainsPath] childByAutoId];
    [newFountain setValue:[fountain dictionaryVersion] withCompletionBlock:^(NSError *error, Firebase *ref) {
        if (error)
            NSLog(@"Error creating fountain: %@", error);
        else
            NSLog(@"Created fountain!");
    }];
}

@end

NSString* const FFFirebaseFountainsChanged = @"FFFirebaseFountainsChanged";