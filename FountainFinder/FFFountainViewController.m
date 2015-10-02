//
//  FFFountainViewController.m
//  FountainFinder
//
//  Created by Spencer Phippen on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import "FFFountainViewController.h"

#import "FFFountainView.h"
#import "FFFirebase.h"
#import "FFAddFountainViewController.h"

@interface FFFountainViewController () <MKMapViewDelegate, UIGestureRecognizerDelegate>
@end

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

    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnMap:)];
    [tap setNumberOfTapsRequired:2];
    [tap setDelegate:self];
    [[[self fountainView] mapView] addGestureRecognizer:tap];
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

- (void) tapOnMap:(UITapGestureRecognizer*)tap {
    if ([tap state] == UIGestureRecognizerStateEnded) {
        MKMapView* mapView = [[self fountainView] mapView];
        CGPoint loc = [tap locationInView:mapView];
        CLLocationCoordinate2D coord = [mapView convertPoint:loc toCoordinateFromView:mapView];

        FFAddFountainViewController* vc = [FFAddFountainViewController new];
        typeof(self) __weak weakSelf = self;
        [vc setCompletion:^(FFFountain* fountain) {
            typeof(self) __strong strongSelf = weakSelf;
            [fountain setCoordinate:coord];
            [FFFirebase addFountain:fountain];
            [strongSelf dismissViewControllerAnimated:TRUE completion:nil];
        }];
        [self presentViewController:vc animated:TRUE completion:nil];
    }
}

#pragma mark UIGestureRecognizerDelegate Methods
- (BOOL) gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer {
    return TRUE;
}

@end
