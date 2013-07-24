//
//  PDFView.m
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix Limited. All rights reserved.
//

#import "PDFView.h"


@implementation PDFView

@synthesize page = m_page;
@synthesize resourceName = m_resourceName;
@synthesize resourceURL = m_resourceURL;
@synthesize resourceData = m_resourceData;


- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
	
    if (self) 
	{
        // Initialization code.
        m_page = 1;
    }
    return self;
}


-(void)setResourceName:(NSString *)resourceName
{
	m_resourceName = resourceName;
	
    self.resourceURL = [ PDFView resourceURLForName: self.resourceName ];
}


-(void)setResourceURL:(NSURL *)resourceURL
{
    m_resourceURL = resourceURL;
    
    [ self setNeedsDisplay ];
}

-(void)setResourceData:(NSData *)data
{
    m_resourceData = data;

    [ self setNeedsDisplay ];
}


+(CGRect) mediaRect:(NSString *)resourceName
{
    return [ PDFView mediaRectForURL:[ PDFView resourceURLForName: resourceName ]];
}


+(CGRect) mediaRectForURL:(NSURL *)resourceURL
{
    return [ self mediaRectForURL:resourceURL atPage:1 ];
}


+(CGRect) mediaRectForURL:(NSURL *)resourceURL atPage:(int)page
{
    CGRect rect = CGRectNull;
    
    if( resourceURL )
	{
		CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL( (__bridge CFURLRef) resourceURL );
		CGPDFPageRef page1 = CGPDFDocumentGetPage( pdf, page );
		
		rect = CGPDFPageGetBoxRect( page1, kCGPDFCropBox );
		
		CGPDFDocumentRelease( pdf );
	}
    
    return rect;
}

+(CGRect) mediaRectForData:(NSData *)data atPage:(int)page
{
    CGRect rect = CGRectNull;

    if( data )
    {
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
        CGPDFDocumentRef pdf = CGPDFDocumentCreateWithProvider(provider);
        CGDataProviderRelease(provider);
        CGPDFPageRef page1 = CGPDFDocumentGetPage( pdf, page );

        rect = CGPDFPageGetBoxRect( page1, kCGPDFCropBox );

        CGPDFDocumentRelease( pdf );
    }
    
    return rect;
}


+(int) pageCountForURL:(NSURL *)resourceURL
{
    int pageCount = 1;
    
    if( resourceURL )
	{
		CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL( (__bridge CFURLRef) resourceURL );
		
		pageCount = CGPDFDocumentGetNumberOfPages( pdf );
		
		CGPDFDocumentRelease( pdf );
	}
    
    return pageCount;
}


+(NSURL *)resourceURLForName:(NSString *)resourceName
{
    NSString *path = [[ NSBundle mainBundle ] pathForResource:resourceName ofType:nil ];
    if( path == nil )
    {
        return nil;
    }
    else
    {
        return ( resourceName ) ? [ NSURL fileURLWithPath:path] : nil;
    }
}


+(void)renderIntoContext:(CGContextRef)ctx url:(NSURL *)resourceURL data:(NSData *)resourceData size:(CGSize)size page:(int)page
{
    if ( resourceURL || resourceData )
    {
        /*
		 * Reference: http://www.cocoanetics.com/2010/06/rendering-pdf-is-easier-than-you-thought/
		 */
        CGContextGetCTM( ctx );
		CGContextScaleCTM( ctx, 1, -1 );
		CGContextTranslateCTM( ctx, 0, -size.height );
        
        CGPDFDocumentRef pdf;
        
        if( resourceURL )
        {
            pdf = CGPDFDocumentCreateWithURL( (__bridge CFURLRef) resourceURL );
        }
        else
        {
            CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)resourceData);
            pdf = CGPDFDocumentCreateWithProvider(provider);
            CGDataProviderRelease(provider);
        }
        
		CGPDFPageRef page1 = CGPDFDocumentGetPage( pdf, page );
        
		CGRect mediaRect = CGPDFPageGetBoxRect( page1, kCGPDFCropBox );
		CGContextScaleCTM( ctx, size.width / mediaRect.size.width, size.height / mediaRect.size.height );
		CGContextTranslateCTM( ctx, -mediaRect.origin.x, -mediaRect.origin.y );
        
		CGContextDrawPDFPage( ctx, page1 );
		CGPDFDocumentRelease( pdf );
        
    }
}



/**/
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [ self.backgroundColor set ];
    CGContextFillRect( ctx, rect );
    
    [[ self class ] renderIntoContext:ctx url:self.resourceURL data:self.resourceData size:rect.size page:self.page ];
}




@end
