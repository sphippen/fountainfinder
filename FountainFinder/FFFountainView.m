//
//  FFFountainView.m
//  FountainFinder
//
//  Created by Spencer Phippen on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import "FFFountainView.h"

@implementation FFFountainView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self)
        return nil;

    _mapView = [[MKMapView alloc] init];

    [self addSubview:_mapView];

    return self;
}

- (void) layoutSubviews {
    [_mapView setFrame:[self bounds]];
}

@end
