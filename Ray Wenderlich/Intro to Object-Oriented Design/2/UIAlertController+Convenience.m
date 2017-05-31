//
//  UIAlertController+Convenience.m
//  Vehicles
//
//  Created by Len512 on 31/05/2017.
//  Copyright © 2017 Designated Nerd Software. All rights reserved.
//

#import "UIAlertController+Convenience.h"

@implementation UIAlertController (Convenience)

+ (void) showSimpleAlertWithTitle: (NSString *) title andMessage: (NSString *) message {
    UIAlertController *simpleAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [simpleAlert addAction:ok];
    
    id rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;

    [rootViewController presentViewController:simpleAlert animated:YES completion:nil];
}

@end
