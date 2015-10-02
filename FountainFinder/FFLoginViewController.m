//
//  FFLoginViewController.m
//  FountainFinder
//
//  Created by Andy Soto on 2015/10/01.
//  Copyright © 2015年 sphippen. All rights reserved.
//

#import "FFLoginViewController.h"

#import "FFFountainViewController.h"
#import "FFLoginView.h"
#import "FFFirebase.h"

@interface FFLoginViewController ()

@end

@implementation FFLoginViewController

- (instancetype) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self)
        return nil;

    [self setTitle:@"Login"];

    return self;
}

- (void) loadView {
    [self setView:[FFLoginView new]];
}

- (FFLoginView*) loginView {
    return (FFLoginView*)[self view];
}

- (void) viewDidLoad {
    [[[self loginView] loginButton] addTarget:self action:@selector(loginPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) loginPressed:(UIButton*)button {
    NSString* username = [[[self loginView] username] text];
    NSString* password = [[[self loginView] password] text];

    [[FFFirebase f] authUser:username password:password withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if (error) {
            NSLog(@"auth error: %@", error);
            return;
        }

        FFFountainViewController* vc = [FFFountainViewController new];
        [[self navigationController] pushViewController:vc animated:FALSE];
    }];
}

@end
