//
//  UIImage+PDF.m
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix Limited. All rights reserved.
//

#import "UIImage+PDF.h"


@implementation  UIImage( PDF )

+(UIImage *) imageWithPDFNamed:(NSString *)resourceName atSize:(CGSize)size
{
	PDFView *pdfView = [[[ PDFView alloc ] initWithFrame:CGRectMake( 0, 0, size.width, size.height ) ] autorelease ];
	pdfView.backgroundColor = [ UIColor clearColor ];
	pdfView.resourceName = resourceName;
	
	return [ pdfView image ];
}

@end
