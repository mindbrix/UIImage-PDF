//
//  UIImage_PDF_exampleViewController.m
//  UIImage+PDF example
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix. All rights reserved.
//

#import "UIImage_PDF_exampleViewController.h"

@interface UIImage_PDF_exampleViewController ()

@property (nonatomic, strong) NSMutableArray *collection;

@end

@implementation UIImage_PDF_exampleViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/**/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    /* Draw a growing line of buttons to demonstate the scaling
	 */
	CGFloat kSpacing = 10;
	CGFloat imageY = kSpacing;

	for(CGFloat i = 0; i < 8; i++)
	{
		/* Always round up coordinates before passing them into UIKit
		 */
		CGFloat imageWidth = ceilf( 22 * sqrtf( i + 1 ));
		CGSize imageSize = CGSizeMake( imageWidth, imageWidth );
        UIImage *image = [ UIImage imageWithPDFNamed:@"YinYang.pdf" atSize:imageSize ];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageY, imageSize.width, imageSize.height)];
        imageView.image = image;
		[ self.view addSubview:imageView ];
		
		imageY += imageWidth + kSpacing;
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
