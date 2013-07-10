UIImage+PDF
===========

`UIImage+PDF` provides a `UIImage` class category method to render a `UIImage` from any PDF stored in the application bundle. The motivation for this was to enable the easy use of scaleable vector assets in `iOS` apps.


Usage
-----

Add the sources files in the `UIImage+PDF` sub folder to your project. Use the following line to import the necessary methods.

	#import "UIImage+PDF.h"
	
Then simply call one of the `UIImage` class methods as shown here:

	UIImage *img = [ UIImage imageWithPDFNamed:@"YingYang.pdf" atSize:CGSizeMake( 40, 40 ) ];
	UIImage *img = [ UIImage imageWithPDFNamed:@"YingYang.pdf" fitSize:CGSizeMake( 90, 50 ) ];
	UIImage *img = [ UIImage imageWithPDFNamed:@"YingYang.pdf" atWidth:60 ];
	UIImage *img = [ UIImage imageWithPDFNamed:@"YingYang.pdf" atHeight:90 ];
	UIImage *img = [ UIImage originalSizeImageWithPDFNamed:@"YingYang.pdf" ];
	
	UIImage *img = [ UIImage imageWithPDFURL:url atSize:CGSizeMake( 60, 60 ) atPage:1 ];
	
	UIImage *img = [ UIImage imageWithPDFData:data atSize:CGSizeMake( 60, 60 ) atPage:1 ];


The `fitSize:`, `atWidth:` and `atHeight:` methods are particularly useful as they preserve the aspect ratio of the source PDF.

For a full API list consult the header file.

An example project is included in this repository. The important code is in `viewDidLoad:` in `UIImage_PDF_exampleViewController.m`.


ARC
---

_**If your project doesn't use ARC**: you must add the `-fobjc-arc` compiler flag to `NSData+MD5.m`, `NSString+MD5.m`, `PDFView.m`, `UIImage+PDF.m` and `UIView+Image.m` in Target Settings ==> Build Phases ==> Compile Sources._


Disk Cacheing 
--------------

`UIImage+PDF` now transparently caches all rendered PDFs in `<Application_Home>/Library/Caches/__PDF_CACHE__`. This substantially improves application latency with large PDFs, especially on the new iPad. To disable cacheing, comment out `#define UIIMAGE_PDF_CACHEING    1` in `UIImage+PDF.h`.


Memory Cacheing 
--------------

`UIImage+PDF` can now use `NSCache` to cache rendered PDFs in memory. This feature is disabled by default. To enable it call:

	[ UIImage setShouldCacheInMemory:YES ];



PDF file size
-------------

By default Adobe Illustrator saves exported PDFs very inefficiently. For best results, export in EPS format, load this into Preview and then save as a PDF. The included example file `YingYang.pdf` shrunk to 10% of its original size with this workflow.

Other vector graphics editors which natively use the OSX Quartz renderer, such as Sketch, will create much more compact PDFs.

The amazing devs at [Panic](http://www.panic.com/) have now released a PDF shrinking utility, [ShrinkIt](http://www.panic.com/blog/2010/02/shrinkit-1-0/), which should take a lot of the pain out of a vector asset workflow.


Licence
-------

Copyright 2012 Nigel Timothy Barber - [@mindbrix](http://twitter.com/mindbrix). All rights reserved.

Permission is given to use this source code file without charge in any project, commercial or otherwise, entirely at your risk, with the condition that any redistribution (in part or whole) of source code must retain this copyright and permission notice. Attribution in compiled projects is appreciated but not required.


Further Reading
---------------

[Matt Gemmell](http://twitter.com/mattgemmell) has an excellent article on his blog explaining [how to use PDF images in iOS apps](http://mattgemmell.com/2012/02/10/using-pdf-images-in-ios-apps/).
