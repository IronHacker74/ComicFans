//
//  BrowseMediatingControllerTests.swift
//  ComicFansTests
//
//  Created by Andrew Masters on 11/22/23.
//

import XCTest
@testable import ComicFans

final class BrowseMediatingControllerTests: XCTestCase {
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
        let controller = BrowseMediatingController(delegate: nil, screenTitle: "")
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertNotNil(controller.searchbar)
        XCTAssertNotNil(controller.attributionLabel)
        XCTAssertNotNil(controller.browseContentView)
        XCTAssertNotNil(controller.browseContentView.arrangedSubviews.first(where: { $0 is BrowseCollectionView }))
        XCTAssertNotNil(controller.singleViewButton)
        XCTAssertNotNil(controller.multiViewButton)
    }

    func testIBActionsAreNotNil() {
        // given
        let controller = BrowseMediatingController(delegate: nil, screenTitle: "")
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertNotNil(controller.singleViewButton.actions(forTarget: controller, forControlEvent: .touchUpInside))
        XCTAssertNotNil(controller.multiViewButton.actions(forTarget: controller, forControlEvent: .touchUpInside))
    }
    
    func testTitleIsSet() {
        // given
        let controller = BrowseMediatingController(delegate: nil, screenTitle: self.string)
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertEqual(controller.navigationItem.title, self.string)
    }
    
    func testCollectionViewIsSet() {
        // given
        let controller = BrowseMediatingController(delegate: nil, screenTitle: "")
        // when
        controller.loadViewIfNeeded()
        controller.setBrowseCollectionViewData([self.dataset])
        // then
        guard let browseCollectionView = controller.browseContentView.arrangedSubviews.first(where: { $0 is BrowseCollectionView}) as? BrowseCollectionView else {
            XCTFail("first arranged subview is not a collection view")
            return
        }
        XCTAssertTrue(browseCollectionView.browseData.count == 1)
    }
    
    func testAttributionTextIsSet() {
        // given
        let controller = BrowseMediatingController(delegate: nil, screenTitle: "")
        // when
        controller.loadViewIfNeeded()
        controller.updateAttributionText(self.string)
        // then
        XCTAssertEqual(controller.attributionLabel.text, self.string)
    }
    
    func testCollectionViewIsAppended() {
        // given
        let controller = BrowseMediatingController(delegate: nil, screenTitle: "")
        // when
        controller.loadViewIfNeeded()
        controller.setBrowseCollectionViewData([self.dataset])
        controller.appendToBrowseCollectionViewData([self.dataset])
        // then
        guard let browseCollectionView = controller.browseContentView.arrangedSubviews.first(where: { $0 is BrowseCollectionView}) as? BrowseCollectionView else {
            XCTFail("first arranged subview is not a collection view")
            return
        }
        XCTAssertTrue(browseCollectionView.browseData.count == 2)
    }
}
