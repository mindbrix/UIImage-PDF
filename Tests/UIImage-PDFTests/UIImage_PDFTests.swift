import XCTest
@testable import UIImage_PDF

final class UIImage_PDFTests: XCTestCase {
    func testExample() throws {
        let url = Bundle.module.url(forResource: "YinYang", withExtension: "pdf")
        XCTAssertNotNil(url)
        
        let size = CGSize(width: 200, height: 200)
        let image = UIImage(pdfurl: url, at: size)
        XCTAssertNotNil(image)
        
        XCTAssertEqual(image!.size, size)
    }
}
