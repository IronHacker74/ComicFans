//
//  HomeMediatingControllerTests.swift
//  ComicFansTests
//
//  Created by Andrew Masters on 11/5/23.
//

import XCTest
@testable import ComicFans

final class HomeMediatingControllerTests: XCTestCase {
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
        let controller = HomeMediatingController.loadFromNibMain()
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertNotNil(controller.collectionview)
        XCTAssertNotNil(controller.tableview)
        XCTAssertNotNil(controller.attributionLabel)
    }
    
    func testUpdateEventsIsSet() {
        // given
        let controller = HomeMediatingController.loadFromNibMain()
        // when
        controller.loadViewIfNeeded()
        controller.updateEvents([self.dataset])
        // then
        XCTAssertEqual(controller.tableview.numberOfRows(inSection: 0), 1)
    }
    
    func testUpdateCategoriesIsSet() {
        // given
        let controller = HomeMediatingController.loadFromNibMain()
        let categories = [BrowseType.characters]
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertEqual(controller.collectionview.numberOfItems(inSection: 0), 6)
    }
    
    func testAttributionTextIsSet() {
        // given
        let controller = HomeMediatingController.loadFromNibMain()
        // when
        controller.loadViewIfNeeded()
        controller.updateAttributionText(self.string)
        // then
        XCTAssertEqual(controller.attributionLabel.text, self.string)
    }
}
