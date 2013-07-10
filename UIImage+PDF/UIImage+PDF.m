//
//  UIImage+PDF.m
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix Limited. All rights reserved.
//

#import "UIImage+PDF.h"


@implementation  UIImage( PDF )


#pragma mark - Control cache

static NSCache *_imagesCache;
static BOOL _shouldCache = NO;

/*!
 @abstract
 Set the caching in memory of images on and off
 
 @param shouldCache to activate the caching
 
 @discussion this method sets up an NSCache for the images and the flag responsible to check them when reqeusted
 
 */

+ (void)setShouldCacheInMemory:(BOOL)shouldCache {
    _shouldCache = shouldCache;
    if (_shouldCache && !_imagesCache) {
        _imagesCache = [[NSCache alloc] init];
    }
}


#pragma mark - Convenience methods

+(UIImage *) imageOrPDFNamed:(NSString *)resourceName
{
    if([[ resourceName pathExtension ] isEqualToString: @"pdf" ])
    {
        return [ UIImage originalSizeImageWithPDFNamed:resourceName ];
    }
    else
    {
        return [ UIImage imageNamed:resourceName ];
    }
}


+(UIImage *) imageOrPDFWithContentsOfFile:(NSString *)path
{
    if([[ path pathExtension ] isEqualToString: @"pdf" ])
    {
        return [ UIImage originalSizeImageWithPDFURL:[ NSURL fileURLWithPath:path ]];
    }
    else
    {
        return [ UIImage imageWithContentsOfFile:path ];
    }
}


#pragma mark - Cacheing

+(NSString *)cacheFilenameForData:(NSData *)resourceData atSize:(CGSize)size atScaleFactor:(CGFloat)scaleFactor atPage:(int)page
{
    NSString *cacheFilename = nil;
    
#ifdef UIIMAGE_PDF_CACHEING
    
    NSFileManager *fileManager = [ NSFileManager defaultManager ];
    
   
    NSString *cacheRoot = [ NSString stringWithFormat:@"%@ - %@ - %d", [ resourceData MD5 ], NSStringFromCGSize(CGSizeMake( size.width * scaleFactor, size.height * scaleFactor )), page ];
    
    //NSLog( @"cacheRoot: %@", cacheRoot );
    
    NSString *MD5 = [ cacheRoot MD5 ];
    
    //NSLog( @"MD5: %@", MD5 );
    
    NSString *cachesDirectory = [ NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex:0 ];
    
    NSString *cacheDirectory = [ NSString stringWithFormat:@"%@/__PDF_CACHE__", cachesDirectory ];
    
    //NSLog( @"cacheDirectory: %@", cacheDirectory );
    
    [ fileManager createDirectoryAtPath:cacheDirectory withIntermediateDirectories:YES attributes:nil error:NULL ];
    
    cacheFilename = [ NSString stringWithFormat:@"%@/%@.png", cacheDirectory, MD5 ];
    
    //NSLog( @"cacheFilename: %@", cacheFilename );
    
#endif
    
    return cacheFilename;
}


+(NSString *)cacheFilenameForURL:(NSURL *)resourceURL atSize:(CGSize)size atScaleFactor:(CGFloat)scaleFactor atPage:(int)page
{
    NSString *cacheFilename = nil;
    
#ifdef UIIMAGE_PDF_CACHEING
    
    NSFileManager *fileManager = [ NSFileManager defaultManager ];
    
    NSString *filePath = [ resourceURL path ];
    
    //NSLog( @"filePath: %@", filePath );
    
    NSDictionary *fileAttributes = [ fileManager attributesOfItemAtPath:filePath error:NULL ];
    
    //NSLog( @"fileAttributes: %@", fileAttributes );
    
    NSString *cacheRoot = [ NSString stringWithFormat:@"%@ - %@ - %@ - %@ - %d", [ filePath lastPathComponent ], [ fileAttributes objectForKey:NSFileSize ], [ fileAttributes objectForKey:NSFileModificationDate ], NSStringFromCGSize(CGSizeMake( size.width * scaleFactor, size.height * scaleFactor )), page ];
    
    //NSLog( @"cacheRoot: %@", cacheRoot );
    
    NSString *MD5 = [ cacheRoot MD5 ];
    
    //NSLog( @"MD5: %@", MD5 );
    
    NSString *cachesDirectory = [ NSSearchPathForDirectoriesInDomains( NSCachesDirectory, NSUserDomainMask, YES ) objectAtIndex:0 ];
    
    NSString *cacheDirectory = [ NSString stringWithFormat:@"%@/__PDF_CACHE__", cachesDirectory ];
    
    //NSLog( @"cacheDirectory: %@", cacheDirectory );
    
    [ fileManager createDirectoryAtPath:cacheDirectory withIntermediateDirectories:YES attributes:nil error:NULL ];
    
    cacheFilename = [ NSString stringWithFormat:@"%@/%@.png", cacheDirectory, MD5 ];
    
    //NSLog( @"cacheFilename: %@", cacheFilename );
    
#endif
    
    return cacheFilename;
}



#pragma mark - Resource name

+(UIImage *) imageWithPDFNamed:(NSString *)resourceName atSize:(CGSize)size atPage:(int)page
{
    return [ self imageWithPDFURL:[ PDFView resourceURLForName:resourceName ] atSize:size atPage:page ];
}

+(UIImage *) imageWithPDFNamed:(NSString *)resourceName atSize:(CGSize)size
{
    return [ self imageWithPDFURL:[ PDFView resourceURLForName:resourceName ] atSize:size ];
}



+(UIImage *) imageWithPDFNamed:(NSString *)resourceName atWidth:(CGFloat)width atPage:(int)page
{
    return [ self imageWithPDFURL:[ PDFView resourceURLForName:resourceName ] atWidth:width atPage:page ];
}

+(UIImage *) imageWithPDFNamed:(NSString *)resourceName atWidth:(CGFloat)width
{
    return [ self imageWithPDFURL:[ PDFView resourceURLForName:resourceName ] atWidth:width ];
}



+(UIImage *) imageWithPDFNamed:(NSString *)resourceName atHeight:(CGFloat)height atPage:(int)page
{
    return [ self imageWithPDFURL:[ PDFView resourceURLForName:resourceName ] atHeight:height atPage:page ];
}

+(UIImage *) imageWithPDFNamed:(NSString *)resourceName atHeight:(CGFloat)height
{
    return [ self imageWithPDFURL:[ PDFView resourceURLForName:resourceName ] atHeight:height ];
}

+(UIImage *) imageWithPDFNamed:(NSString *)resourceName fitSize:(CGSize)size atPage:(int)page
{
    return [ self imageWithPDFURL:[ PDFView resourceURLForName:resourceName] fitSize:size atPage:page ];
}

+(UIImage *) imageWithPDFNamed:(NSString *)resourceName fitSize:(CGSize)size
{
    return [ self imageWithPDFURL:[ PDFView resourceURLForName:resourceName] fitSize:size ];
}


+(UIImage *) originalSizeImageWithPDFNamed:(NSString *)resourceName atPage:(int)page
{
    return [ self originalSizeImageWithPDFURL:[ PDFView resourceURLForName:resourceName ] atPage:page ];
}

+(UIImage *) originalSizeImageWithPDFNamed:(NSString *)resourceName
{
    return [ self originalSizeImageWithPDFURL:[ PDFView resourceURLForName:resourceName ]];
}

+(UIImage *) originalSizeImageWithPDFData:(NSData *)data
{
    CGRect mediaRect = [ PDFView mediaRectForData:data atPage:1 ];

    return [ UIImage imageWithPDFData:data atSize:mediaRect.size atPage:1 ];
}

#pragma mark - Resource URLs

+(UIImage *) imageWithPDFData:(NSData *)data atSize:(CGSize)size atPage:(int)page
{
    UIImage *pdfImage = nil;
    
    //PDFView *pdfView = [[ PDFView alloc ] initWithFrame:CGRectMake( 0, 0, size.width, size.height ) ];

    NSString *cacheFilename = [ self cacheFilenameForData:data atSize:size atScaleFactor:[ UIScreen mainScreen ].scale atPage:page ];
    
    if([[ NSFileManager defaultManager ] fileExistsAtPath:cacheFilename ])
    {
       //NSLog( @"Cache hit" );
        
        pdfImage = [ UIImage imageWithCGImage:[[ UIImage imageWithContentsOfFile:cacheFilename ] CGImage ] scale:[ UIScreen mainScreen ].scale orientation:UIImageOrientationUp ];
    }
    else
    {
       //NSLog( @"Cache miss" );
        
        UIGraphicsBeginImageContextWithOptions( size, NO, [ UIScreen mainScreen ].scale );
        
        [ PDFView renderIntoContext:UIGraphicsGetCurrentContext() url:nil data:data size:size page:page ];
        pdfImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if( cacheFilename )
        {
            [ UIImagePNGRepresentation( pdfImage ) writeToFile:cacheFilename atomically:NO ];
        }
    }
    
    return pdfImage;
}



+(UIImage *) imageWithPDFURL:(NSURL *)URL atSize:(CGSize)size atPage:(int)page
{
    UIImage *pdfImage = nil;
    
    NSString *cacheFilename = [ self cacheFilenameForURL:URL atSize:size atScaleFactor:[ UIScreen mainScreen ].scale atPage:page ];
    
    
    /**
     * Check in Memeory cached image before checking file system
     */
    if (_shouldCache)
    {
        pdfImage = [_imagesCache objectForKey:cacheFilename];
        if (pdfImage) return pdfImage;
    }
    
    
    if([[ NSFileManager defaultManager ] fileExistsAtPath:cacheFilename ])
    {
        //NSLog( @"Cache hit" );
        
        pdfImage = [ UIImage imageWithCGImage:[[ UIImage imageWithContentsOfFile:cacheFilename ] CGImage ] scale:[ UIScreen mainScreen ].scale orientation:UIImageOrientationUp ];
    }
    else 
    {
        //NSLog( @"Cache miss" );
    
        UIGraphicsBeginImageContextWithOptions( size, NO, [ UIScreen mainScreen ].scale );
        
        [ PDFView renderIntoContext:UIGraphicsGetCurrentContext() url:URL data:nil size:size page:page ];
        pdfImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if( cacheFilename )
        {
            [ UIImagePNGRepresentation( pdfImage ) writeToFile:cacheFilename atomically:NO ];
        }
    }
    /**
     * Cache image to in memory if active
     */
    
    if (pdfImage && cacheFilename && _shouldCache)
    {
        [_imagesCache setObject:pdfImage forKey:cacheFilename];
    }
    
	return pdfImage;
}

+(UIImage *) imageWithPDFURL:(NSURL *)URL atSize:(CGSize)size
{
    return [ self imageWithPDFURL:URL atSize:size atPage:1 ];
}


+(UIImage *) imageWithPDFURL:(NSURL *)URL fitSize:(CGSize)size atPage:(int)page
{
    if ( URL == nil )
    {
        return nil;
    }
    
    // Get dimensions
    CGRect mediaRect = [ PDFView mediaRectForURL:URL atPage:page ];
    
    // Calculate scale factor
    CGFloat scaleFactor = MAX(mediaRect.size.width / size.width, mediaRect.size.height / size.height);
    
    // Create new size
    CGSize newSize = CGSizeMake( ceilf( mediaRect.size.width / scaleFactor ), ceilf( mediaRect.size.height / scaleFactor ));
    
    // Return image
    return [ UIImage imageWithPDFURL:URL atSize:newSize atPage:page ];
}

+(UIImage *) imageWithPDFURL:(NSURL *)URL fitSize:(CGSize)size
{
    return [ UIImage imageWithPDFURL:URL fitSize:size atPage:1 ];
}


+(UIImage *) imageWithPDFURL:(NSURL *)URL atWidth:(CGFloat)width atPage:(int)page
{
    if ( URL == nil )
    {
        return nil;
    }
    
    CGRect mediaRect = [ PDFView mediaRectForURL:URL atPage:page ];
    CGFloat aspectRatio = mediaRect.size.width / mediaRect.size.height;
    
    CGSize size = CGSizeMake( width, ceilf( width / aspectRatio ));
    
    return [ UIImage imageWithPDFURL:URL atSize:size atPage:page ];
}

+(UIImage *) imageWithPDFURL:(NSURL *)URL atWidth:(CGFloat)width
{
    return [ UIImage imageWithPDFURL:URL atWidth:width atPage:1 ];
}



+(UIImage *) imageWithPDFURL:(NSURL *)URL atHeight:(CGFloat)height atPage:(int)page
{
    if ( URL == nil )
    {
        return nil;
    }
    
    CGRect mediaRect = [ PDFView mediaRectForURL:URL atPage:page ];
    CGFloat aspectRatio = mediaRect.size.width / mediaRect.size.height;
    
    CGSize size = CGSizeMake( ceilf( height * aspectRatio ), height );
    
    return [ UIImage imageWithPDFURL:URL atSize:size atPage:page ];
}

+(UIImage *) imageWithPDFURL:(NSURL *)URL atHeight:(CGFloat)height
{
    return [ UIImage imageWithPDFURL:URL atHeight:height atPage:1 ];
}



+(UIImage *) originalSizeImageWithPDFURL:(NSURL *)URL atPage:(int)page
{
    if ( URL == nil )
    {
        return nil;
    }
    
    CGRect mediaRect = [ PDFView mediaRectForURL:URL atPage:page ];
    
    return [ UIImage imageWithPDFURL:URL atSize:mediaRect.size atPage:page ];
}

+(UIImage *) originalSizeImageWithPDFURL:(NSURL *)URL
{
    return [ UIImage originalSizeImageWithPDFURL:URL atPage:1 ];
}



@end
