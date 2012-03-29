//
//  UIImage+PDF.m
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix Limited. All rights reserved.
//

#import "UIImage+PDF.h"


@implementation  UIImage( PDF )


#pragma mark - Resource name

+(UIImage *) imageWithPDFNamed:(NSString *)resourceName atSize:(CGSize)size
{
	PDFView *pdfView = [[[ PDFView alloc ] initWithFrame:CGRectMake( 0, 0, size.width, size.height ) ] autorelease ];
	pdfView.backgroundColor = [ UIColor clearColor ];
	pdfView.resourceName = resourceName;
	
	return [ pdfView image ];
}


+(UIImage *) imageWithPDFNamed:(NSString *)resourceName atWidth:(CGFloat)width
{
    CGRect mediaRect = [ PDFView mediaRect:resourceName ];
    CGFloat aspectRatio = mediaRect.size.width / mediaRect.size.height;
    
    CGSize size = CGSizeMake( width, ceilf( width / aspectRatio ));
    
    return [ UIImage imageWithPDFNamed:resourceName atSize:size ];
}


+(UIImage *) imageWithPDFNamed:(NSString *)resourceName atHeight:(CGFloat)height
{
    CGRect mediaRect = [ PDFView mediaRect:resourceName ];
    CGFloat aspectRatio = mediaRect.size.width / mediaRect.size.height;
    
    CGSize size = CGSizeMake( ceilf( height * aspectRatio ), height );
    
    return [ UIImage imageWithPDFNamed:resourceName atSize:size ];
}


+(UIImage *) originalSizeImageWithPDFNamed:(NSString *)resourceName
{
    CGRect mediaRect = [ PDFView mediaRect:resourceName ];
    
    return [ UIImage imageWithPDFNamed:resourceName atSize:mediaRect.size ];
}


#pragma mark - Resource URLs

+(UIImage *) imageWithPDFURL:(NSURL *)URL atSize:(CGSize)size
{
    PDFView *pdfView = [[[ PDFView alloc ] initWithFrame:CGRectMake( 0, 0, size.width, size.height ) ] autorelease ];
	pdfView.backgroundColor = [ UIColor clearColor ];
	pdfView.resourceURL = URL;
	
	return [ pdfView image ];
}


+(UIImage *) imageWithPDFURL:(NSURL *)URL atWidth:(CGFloat)width
{
    CGRect mediaRect = [ PDFView mediaRectForURL:URL ];
    CGFloat aspectRatio = mediaRect.size.width / mediaRect.size.height;
    
    CGSize size = CGSizeMake( width, ceilf( width / aspectRatio ));
    
    return [ UIImage imageWithPDFURL:URL atSize:size ];
}


+(UIImage *) imageWithPDFURL:(NSURL *)URL atHeight:(CGFloat)height
{
    CGRect mediaRect = [ PDFView mediaRectForURL:URL ];
    CGFloat aspectRatio = mediaRect.size.width / mediaRect.size.height;
    
    CGSize size = CGSizeMake( ceilf( height * aspectRatio ), height );
    
    return [ UIImage imageWithPDFURL:URL atSize:size ];
}


+(UIImage *) originalSizeImageWithPDFURL:(NSURL *)URL
{
    CGRect mediaRect = [ PDFView mediaRectForURL:URL ];
    
    return [ UIImage imageWithPDFURL:URL atSize:mediaRect.size ];
}



@end
