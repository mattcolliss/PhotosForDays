//
//  PlaceholderDetailsViewModelTests.swift
//  PhotosForDaysTests
//
//  Created by Matthew Colliss on 14/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import XCTest
@testable import PhotosForDays

class PlaceholderDetailsViewModelTests: XCTestCase {

    var viewModel: PlaceholderDetailsViewModel!

    override func setUp() {
        super.setUp()
        viewModel = PlaceholderDetailsViewModel()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testIcon() {
        XCTAssertNotNil(viewModel.icon)
    }

    func testHintText() {
        XCTAssert(!viewModel.hintText.isEmpty)
    }

}
