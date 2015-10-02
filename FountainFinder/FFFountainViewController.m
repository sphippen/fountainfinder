//
//  FFFountainViewController.m
//  FountainFinder
//
//  Created by Andy Soto on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import "FFFountainViewController.h"

#import "FFFountainView.h"
#import "FFFirebase.h"

@implementation FFFountainViewController {
    NSMutableArray* _annotations;
}

#pragma mark Constructors
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self)
        return nil;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fountainsChanged:) name:FFFirebaseFountainsChanged object:nil];

    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FFFirebaseFountainsChanged object:nil];
}

#pragma mark UIViewController Methods
- (void) loadView {
    [self setView:[FFFountainView new]];
}

- (void) viewDidLoad {
    [[[self fountainView] mapView] setRotateEnabled:FALSE];
}

- (void) viewWillAppear:(BOOL)animated {
    [self positionMap];
    [self updateMap];
}

#pragma mark FFFountainViewController Methods
- (FFFountainView*) fountainView {
    return (FFFountainView*)[self view];
}

- (void) fountainsChanged:(NSNotification*)not {
    if ([self isViewLoaded]) {
        [self updateMap];
    }
}

- (void) positionMap {
    MKMapView* mapView = [[self fountainView] mapView];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(40.76, -111.89), 8000, 8000);
    [mapView setRegion:region];
}

- (void) updateMap {
    MKMapView* mapView = [[self fountainView] mapView];

    if (_annotations) {
        [mapView removeAnnotations:_annotations];
    }
    _annotations = [NSMutableArray new];

    NSArray* fountains = [FFFirebase fountains];
    for (FFFountain* fountain in fountains) {
        [_annotations addObject:fountain];
    }

    [mapView addAnnotations:_annotations];
}

@end
