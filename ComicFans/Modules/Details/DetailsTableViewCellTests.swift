//
//  DetailsTableViewCellTests.swift
//  ComicFansTests
//
//  Created by Andrew Masters on 11/22/23.
//

import XCTest
@testable import ComicFans

final class DetailsTableViewCellTests: XCTestCase {
    private var string: String!
    
    override func setUp() {
        super.setUp()
        self.string = "string"
    }
    
    override func tearDown() {
        super.tearDown()
        self.string = nil
    }

    func testIBOutletsAreNotNil() {
        // given
        let cell = DetailsTableViewCell.loadFromNib()
        // then
        XCTAssertNotNil(cell.label)
    }

    func testConfigureCell() {
        // given
        let cell = DetailsTableViewCell.loadFromNib()
        // then
        cell.configureCell(text: self.string)
        // then
        XCTAssertEqual(cell.label.text, self.string)
    }
}
