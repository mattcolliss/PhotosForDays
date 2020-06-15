//
//  SelectDateViewModelTests.swift
//  PhotosForDaysTests
//
//  Created by Matthew Colliss on 14/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import XCTest
@testable import PhotosForDays

class SelectDateViewModelTests: XCTestCase {

    var viewModel: SelectDateViewModel!

    override func setUp() {
        super.setUp()
        viewModel = SelectDateViewModel()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testTitle() {
        XCTAssertFalse(viewModel.title.isEmpty)
    }

    func testHintText() {
        XCTAssertFalse(viewModel.hintText.isEmpty)
    }

    func testMaximumDate() {
        XCTAssertNotNil(viewModel.maximumDate)
    }

    func testMinimumDate() {
        XCTAssertNotNil(viewModel.minimumDate)
    }

    func testSelectedDate() {
        XCTAssertNotNil(viewModel.selectedDate)
    }

    func testStartButtonTitle() {
        XCTAssertFalse(viewModel.startButtonTitle.isEmpty)
    }

    func testSelectDate() {
        let date = Date()
        viewModel.dateSelected(date)
        XCTAssertEqual(date, viewModel.selectedDate)
    }

}
