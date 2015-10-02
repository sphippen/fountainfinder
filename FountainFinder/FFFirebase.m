//
//  FFFirebase.m
//  FountainFinder
//
//  Created by Andy Soto on 2015/10/01.
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
    [[self fountainsPath] observeEventType:(FEventTypeChildAdded | FEventTypeChildRemoved) withBlock:^(FDataSnapshot *snapshot) {
        NSMutableArray* fountains = [NSMutableArray new];
        for (NSDictionary* dict in [snapshot value])
            [fountains addObject:[[FFFountain alloc] initWithDictionary:dict]];

        sFountains = fountains;
        [[NSNotificationCenter defaultCenter] postNotificationName:FFFirebaseFountainsChanged object:nil];
    }];
}

+ (NSArray*) fountains {
    return sFountains;
}

+ (void) addFountain:(FFFountain*)fountain {
    Firebase* newFountain = [[self fountainsPath] childByAutoId];
    [newFountain setValue:[fountain dictionaryVersion]];
}

@end

NSString* const FFFirebaseFountainsChanged = @"FFFirebaseFountainsChanged";