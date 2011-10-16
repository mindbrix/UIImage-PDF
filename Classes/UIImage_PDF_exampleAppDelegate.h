//
//  UIImage_PDF_exampleAppDelegate.h
//  UIImage+PDF example
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UIImage_PDF_exampleViewController;

@interface UIImage_PDF_exampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIImage_PDF_exampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIImage_PDF_exampleViewController *viewController;

@end

