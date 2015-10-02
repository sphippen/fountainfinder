//
//  FFAddFountainView.m
//  FountainFinder
//
//  Created by Andy Soto on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import "FFAddFountainView.h"

@implementation FFAddFountainView {
    UITextField* _nameField;
    UITextField* _tempField;
    UITextField* _pressureField;
    UITextField* _cleanField;
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self)
        return nil;

    UIColor* background = [UIColor colorWithWhite:0.9 alpha:1.0];

    _nameField = [UITextField new];
    [_nameField setPlaceholder:@"Name"];
    [_nameField setBackgroundColor:background];

    _tempField = [UITextField new];
    [_tempField setPlaceholder:@"Temperature (1-5, 1 = bad, 5 = good)"];
    [_tempField setBackgroundColor:background];

    _pressureField = [UITextField new];
    [_pressureField setPlaceholder:@"Pressure (1-5, 1 = bad, 5 = good)"];
    [_pressureField setBackgroundColor:background];

    _cleanField = [UITextField new];
    [_cleanField setPlaceholder:@"Clean (1-5, 1 = bad, 5 = good)"];
    [_cleanField setBackgroundColor:background];

    _makeFountain = [UIButton buttonWithType:UIButtonTypeCustom];
    [_makeFountain setTitle:@"Add Fountain" forState:UIControlStateNormal];
    [_makeFountain setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_makeFountain setBackgroundColor:background];

    [self addSubview:_nameField];
    [self addSubview:_tempField];
    [self addSubview:_pressureField];
    [self addSubview:_cleanField];
    [self addSubview:_makeFountain];

    return self;
}

#pragma mark Properties
- (NSString*) name {
    return [_nameField text];
}

- (int) temperature {
    return [[_tempField text] intValue];
}

- (int) pressure {
    return [[_pressureField text] intValue];
}

- (int) cleanliness {
    return [[_cleanField text] intValue];
}

#pragma mark UIView Methods
- (void) layoutSubviews {
    const CGRect entireArea = [self bounds];

    CGRect nameFrame = CGRectZero;
    CGRect tempFrame = CGRectZero;
    CGRect pressureFrame = CGRectZero;
    CGRect cleanFrame = CGRectZero;
    CGRect addFrame = CGRectZero;

    static const CGFloat space = 8.0;
    CGFloat height = -space;
    for (UIView* view in @[_nameField, _tempField, _pressureField, _cleanField, _makeFountain]) {
        height += space;
        [view sizeToFit];
        height += [view bounds].size.height;
    }

    CGRect dummy;
    CGRect workingArea = CGRectInset(entireArea, 0.0, (entireArea.size.height - height) * 0.5);

    CGRectDivide(workingArea, &nameFrame, &workingArea, [_nameField bounds].size.height, CGRectMinYEdge);
    CGRectDivide(workingArea, &dummy, &workingArea, space, CGRectMinYEdge);
    CGRectDivide(workingArea, &tempFrame, &workingArea, [_tempField bounds].size.height, CGRectMinYEdge);
    CGRectDivide(workingArea, &dummy, &workingArea, space, CGRectMinYEdge);
    CGRectDivide(workingArea, &pressureFrame, &workingArea, [_pressureField bounds].size.height, CGRectMinYEdge);
    CGRectDivide(workingArea, &dummy, &workingArea, space, CGRectMinYEdge);
    CGRectDivide(workingArea, &cleanFrame, &workingArea, [_cleanField bounds].size.height, CGRectMinYEdge);
    CGRectDivide(workingArea, &dummy, &workingArea, space, CGRectMinYEdge);
    CGRectDivide(workingArea, &addFrame, &workingArea, [_makeFountain bounds].size.height, CGRectMinYEdge);

    [_nameField setFrame:nameFrame];
    [_tempField setFrame:tempFrame];
    [_pressureField setFrame:pressureFrame];
    [_cleanField setFrame:cleanFrame];
    [_makeFountain setFrame:addFrame];
}

@end
