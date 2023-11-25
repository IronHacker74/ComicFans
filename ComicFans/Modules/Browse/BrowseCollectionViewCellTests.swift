//
//  BrowseCollectionViewCellTests.swift
//  ComicFansTests
//
//  Created by Andrew Masters on 11/22/23.
//

import XCTest
@testable import ComicFans

final class BrowseCollectionViewCellTests: XCTestCase {
    private var string: String!
    
    override func setUp() {
        super.setUp()
        self.string = "string"
    }
    
    override func tearDown() {
        super.tearDown()
        self.string = ""
    }
    
    func testIBOutletsAreNotNil() {
        // given
        let cell = BrowseCollectionViewCell.loadFromNib()
        // then
        XCTAssertNotNil(cell.browseImage)
        XCTAssertNotNil(cell.browseTitle)
        XCTAssertNotNil(cell.browseBackgroundView)
    }

    func testTitleIsSet() {
        // given
        let cell = BrowseCollectionViewCell.loadFromNib()
        // when
        cell.configureCell(title: self.string, description: nil)
        // then
        XCTAssertEqual(cell.browseTitle.text, self.string)
    }
    
    func testImageIsSet() {
        // given
        let cell = BrowseCollectionViewCell.loadFromNib()
        let image = UIImage(systemName: "xmark")
        // when
        cell.configureImage(image: image, imagePath: nil, completion: {_ in })
        // then
        XCTAssertEqual(cell.browseImage.image, image)
    }
}
