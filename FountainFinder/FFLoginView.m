//
//  FFLoginView.m
//  FountainFinder
//
//  Created by Andy Soto on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import "FFLoginView.h"

@implementation FFLoginView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self)
        return nil;

    _username = [[UITextField alloc] init];
    [_username setPlaceholder:@"Username"];
    [_username setBackgroundColor:[UIColor lightGrayColor]];

    _password = [[UITextField alloc] init];
    [_password setPlaceholder:@"Password"];
    [_password setSecureTextEntry:TRUE];
    [_password setBackgroundColor:[UIColor lightGrayColor]];

    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:[UIColor lightGrayColor]];

    [self addSubview:_username];
    [self addSubview:_password];
    [self addSubview:_loginButton];

    return self;
}

- (void) layoutSubviews {
    const CGRect entireArea = [self bounds];

    CGRect usernameFrame = CGRectZero;
    CGRect passwordFrame = CGRectZero;
    CGRect loginFrame = CGRectZero;

    const static CGFloat fieldHeight = 32.0;
    const static CGFloat spacing = 8.0;
    const static CGFloat buttonHeight = 32.0;

    const static CGFloat totalHeight = 2*fieldHeight + buttonHeight + 2*spacing;

    CGRect workingArea = entireArea;
    workingArea = CGRectInset(workingArea, 0.0, (entireArea.size.height - totalHeight) * 0.5);

    CGRect dummy;
    CGRectDivide(workingArea, &usernameFrame, &workingArea, fieldHeight, CGRectMinYEdge);
    CGRectDivide(workingArea, &dummy, &workingArea, spacing, CGRectMinYEdge);
    CGRectDivide(workingArea, &passwordFrame, &workingArea, fieldHeight, CGRectMinYEdge);
    CGRectDivide(workingArea, &dummy, &workingArea, spacing, CGRectMinYEdge);
    CGRectDivide(workingArea, &loginFrame, &workingArea, buttonHeight, CGRectMinYEdge);

    [_username setFrame:usernameFrame];
    [_password setFrame:passwordFrame];
    [_loginButton setFrame:loginFrame];
}

@end
