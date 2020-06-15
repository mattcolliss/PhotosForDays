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
        let mockPhotosService = MockPhotosService()
        viewModel = PhotosCollectionViewModel(date: date, photosService: mockPhotosService)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFormattedDate() {
        XCTAssertFalse(viewModel.formattedDate.isEmpty)
    }

    func testFetchPhotos() {

        XCTAssert(viewModel.morePhotosAvailable)
        XCTAssertEqual(viewModel.photos.count, 0)

        viewModel.fetchPhotos()

        XCTAssert(viewModel.morePhotosAvailable)
        XCTAssertEqual(viewModel.photos.count, 1)

        viewModel.fetchPhotos()

        XCTAssert(viewModel.morePhotosAvailable)
        XCTAssertEqual(viewModel.photos.count, 2)

        viewModel.fetchPhotos()

        XCTAssertFalse(viewModel.morePhotosAvailable)
        XCTAssertEqual(viewModel.photos.count, 3)

    }

}
