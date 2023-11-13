//
//  HomeMediatingControllerTests.swift
//  ComicFansTests
//
//  Created by Andrew Masters on 11/5/23.
//

import XCTest
@testable import ComicFans

final class HomeMediatingControllerTests: XCTestCase {

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
}
