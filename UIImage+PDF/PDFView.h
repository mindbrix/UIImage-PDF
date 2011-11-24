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

@property( nonatomic, assign ) NSString *resourceName;

+(CGRect) mediaRect:(NSString *)resourceName;
+(NSURL *)resourceURL:(NSString *)resourceName;
  
@end
