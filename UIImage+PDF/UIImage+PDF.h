//
//  UIImage+PDF.h
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Image.h"
#import "PDFView.h"


@interface UIImage( PDF )

+(UIImage *) imageWithPDFNamed:(NSString *)resourceName atSize:(CGSize)size;
+(UIImage *) imageWithPDFNamed:(NSString *)resourceName atWidth:(CGFloat)width;

@end
