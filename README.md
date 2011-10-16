UIImage+PDF
===========

`UIImage+PDF` provides a `UIImage` class category method to render a `UIImage` from any PDF stored in the application bundle. The motivation for this was to enable the easy use of scaleable vector assets in `iOS` apps.


Usage
-----

Add the sources files in the `UIImage+PDF` sub folder to your project. Use the following line to import the necessary methods.

	#import "UIImage+PDF.h"
	
Then simply call the `UIImage` class method as shown here:

	UIImage *img = [ UIImage imageWithPDFNamed:@"YingYang.pdf" atSize:CGSizeMake( 40, 40 ) ];

An example project is included in this repository. The important code is in `viewDidLoad:` in `UIImage_PDF_exampleViewController.m`.


PDF file size
-------------

By default Adobe Illustrator saves exported PDFs very inefficiently. For best results, export in EPS format, load this into Preview and then save as a PDF. The included example file `YingYang.pdf` shrunk to 10% of its original size with this workflow.

Other vector graphics editors which natively use the OSX Quartz renderer, such as Sketch, will create much more compact PDFs.