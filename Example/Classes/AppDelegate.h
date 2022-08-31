//
//  AppDelegate.h
//  UIImage+PDF example
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ViewController *viewController;

@end

