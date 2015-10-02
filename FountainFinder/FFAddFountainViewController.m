//
//  FFAddFountainViewController.m
//  FountainFinder
//
//  Created by Andy Soto on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import "FFAddFountainViewController.h"

#import "FFAddFountainView.h"

@implementation FFAddFountainViewController

#pragma mark UIViewController Methods
- (void) loadView {
    [self setView:[FFAddFountainView new]];
}

- (void) viewDidLoad {
    [[[self addFountainView] makeFountain] addTarget:self action:@selector(addFountain:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark FFAddFountainViewController Methods
- (FFAddFountainView*) addFountainView {
    return (FFAddFountainView*)[self view];
}

- (void) addFountain:(UIButton*)button {
    if (_completion) {
        FFAddFountainView* view = [self addFountainView];
        FFFountain* fountain = [FFFountain new];
        [fountain setTitle:[view name]];
        [fountain setTemperature:[view temperature]];
        [fountain setPressure:[view pressure]];
        [fountain setCleanliness:[view cleanliness]];
        _completion(fountain);
    }
}

@end
