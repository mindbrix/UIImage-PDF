//
//  UIImage_PDF_exampleViewController.m
//  UIImage+PDF example
//
//  Created by Nigel Barber on 15/10/2011.
//  Copyright 2011 Mindbrix. All rights reserved.
//

#import "UIImage_PDF_exampleViewController.h"

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
	float kInset = 4;
	float kSpacing = 10;
	float buttonY = kSpacing;

	for( float i = 0; i < 8; i++ )
	{
		/* Always round up coordinates before passing them into UIKit
		 */
		float buttonWidth = ceilf( 22 * sqrtf( i + 1 ));
		
		CGSize buttonSize = CGSizeMake( buttonWidth, buttonWidth );
		UIButton *yingYangButton = [ UIButton buttonWithType:UIButtonTypeRoundedRect ];
		yingYangButton.frame = CGRectMake( kSpacing, buttonY, buttonSize.width, buttonSize.height );
		
		/* Inset the button image
		 */
		CGSize imageSize = CGSizeMake( buttonSize.width - kInset * 2, buttonSize.height - kInset * 2 );
		
		/* Set the button image from the PDF asset.
		 */
		[ yingYangButton setImage:[ UIImage imageWithPDFNamed:@"YingYang.pdf" atSize:imageSize ] forState:UIControlStateNormal ];
		
		[ self.view addSubview:yingYangButton ];
		
		buttonY += buttonWidth + kSpacing;
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
