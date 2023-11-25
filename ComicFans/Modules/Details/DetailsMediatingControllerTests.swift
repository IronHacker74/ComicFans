//
//  DetailsMediatingControllerTests.swift
//  ComicFansTests
//
//  Created by Andrew Masters on 11/22/23.
//

import XCTest
@testable import ComicFans

final class DetailsMediatingControllerTests: XCTestCase {
    private var string: String!
    private var dataset: DataSet!
    
    override func setUp() {
        super.setUp()
        self.string = "string"
        self.dataset = DataSet(id: 123, name: self.string, title: self.string, description: self.string, thumbnail: Thumbnail(path: self.string, pathextension: self.string, fullPath: self.string), urls: [URLItem(type: self.string, url: self.string)])
    }
    
    override func tearDown() {
        super.tearDown()
        self.string = nil
        self.dataset = nil
    }
    
    func testIBOutletsAreNotNil() {
        // given
        let controller = DetailsMediatingController(delegate: nil)
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertNotNil(controller.tableview)
        XCTAssertNotNil(controller.attributionLabel)
    }
    
    func testDataDetailsIsSet() {
        // given
        let controller = DetailsMediatingController(delegate: nil)
        // when
        controller.loadViewIfNeeded()
        controller.setOutlets(data: self.dataset, attribution: nil)
        // then
        XCTAssertEqual(controller.tableview.numberOfSections, 1)
    }
}
