//
//  PhotosCollectionViewModelTests.swift
//  PhotosForDaysTests
//
//  Created by Matthew Colliss on 14/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import XCTest
@testable import PhotosForDays

class PhotosCollectionViewModelTests: XCTestCase {

    var viewModel: PhotosCollectionViewModel!

    override func setUp() {
        super.setUp()
        let date = Date()
        viewModel = PhotosCollectionViewModel(date: date)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFormattedDate() {
        XCTAssert(!viewModel.formattedDate.isEmpty)
    }

}
