//
//  PDFView.h
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix Limited. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PDFView : UIView 
{

}

@property( nonatomic, assign ) int page;
@property( nonatomic, strong ) NSString *resourceName;
@property( nonatomic, strong ) NSURL *resourceURL;
@property( nonatomic, strong ) NSData *resourceData;
+(CGRect) mediaRect:(NSString *)resourceName;
+(CGRect) mediaRectForURL:(NSURL *)resourceURL;
+(CGRect) mediaRectForURL:(NSURL *)resourceURL atPage:(int)page;
+(CGRect) mediaRectForData:(NSData *)data atPage:(int)page;
+(int) pageCountForURL:(NSURL *)resourceURL;
+(NSURL *)resourceURLForName:(NSString *)resourceName;
+(void)renderIntoContext:(CGContextRef)ctx url:(NSURL *)resourceURL data:(NSData *)resourceData size:(CGSize)size page:(int)page;

@end
