//
//  PDFView.m
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix Limited. All rights reserved.
//

#import "PDFView.h"


@implementation PDFView

@synthesize resourceName = m_resourceName;


- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
	
    if (self) 
	{
        // Initialization code.
    }
    return self;
}


-(void)setResourceName:(NSString *)resourceName
{
	m_resourceName = resourceName;
	
	[ self setNeedsDisplay ];
}


-(NSURL *)resourceURL
{
	if( self.resourceName )
	{
		return [ NSURL fileURLWithPath:[[ NSBundle mainBundle ] pathForResource:self.resourceName ofType:nil ]];
	}
	else
	{
		return nil;
	}
}



/**/
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect 
{
    // Drawing code.
	if( self.resourceURL )
	{
		/* 
		 * Reference: http://www.cocoanetics.com/2010/06/rendering-pdf-is-easier-than-you-thought/
		 */
		CGContextRef ctx = UIGraphicsGetCurrentContext();
		
		[ self.backgroundColor set ];
		CGContextFillRect( ctx, rect );
		
		CGContextGetCTM( ctx );
		CGContextScaleCTM( ctx, 1, -1 );
		CGContextTranslateCTM( ctx, 0, -self.bounds.size.height );
		
		CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL( (CFURLRef) self.resourceURL );
		CGPDFPageRef page1 = CGPDFDocumentGetPage( pdf, 1 );
		
		CGRect mediaRect = CGPDFPageGetBoxRect( page1, kCGPDFCropBox );
		CGContextScaleCTM( ctx, rect.size.width / mediaRect.size.width, rect.size.height / mediaRect.size.height );
		CGContextTranslateCTM( ctx, -mediaRect.origin.x, -mediaRect.origin.y );
		
		CGContextDrawPDFPage( ctx, page1 );
		CGPDFDocumentRelease( pdf );
	}
}


- (void)dealloc 
{
    [super dealloc];
}


@end
