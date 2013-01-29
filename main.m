//
//  main.m
//  UIImage+PDF example
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ARCSafe_MemMgmt.h"

int main(int argc, char *argv[]) {
    
    int retVal;
    as_autoreleasepool_start(pool);
    retVal = UIApplicationMain(argc, argv, nil, nil);
    as_autoreleasepool_end(pool);
    return retVal;
}
