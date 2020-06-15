//
//  PhotoDetailsVIewModelTests.swift
//  PhotosForDaysTests
//
//  Created by Matthew Colliss on 14/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import XCTest
@testable import PhotosForDays

class PhotoDetailViewModelTests: XCTestCase {

    var viewModel: PhotoDetailsViewModel!

    override func setUp() {
        super.setUp()
        let photo = Photo(id: "id", owner: "owner", secret: "secret", server: "server", farm: 1, title: "title")
        viewModel = PhotoDetailsViewModel(photo: photo)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testPhotoUrl() {
        XCTAssertNotNil(viewModel.photoUrl)
    }

    func testPhotoTitle() {
        XCTAssertFalse(viewModel.photoTitle.isEmpty)
    }

    func testPhotoScaleMode() {
        XCTAssertEqual(viewModel.photoScaleMode, UIView.ContentMode.scaleAspectFill)
    }

    func testTogglePhotoScaleMode() {
        XCTAssertEqual(viewModel.photoScaleMode, UIView.ContentMode.scaleAspectFill)
        viewModel.togglePhotoScaleMode()
        XCTAssertEqual(viewModel.photoScaleMode, UIView.ContentMode.scaleAspectFit)
        viewModel.togglePhotoScaleMode()
        XCTAssertEqual(viewModel.photoScaleMode, UIView.ContentMode.scaleAspectFill)
    }

    func testResetPhotoScaleMode() {
        XCTAssertEqual(viewModel.photoScaleMode, UIView.ContentMode.scaleAspectFill)
        viewModel.togglePhotoScaleMode()
        XCTAssertEqual(viewModel.photoScaleMode, UIView.ContentMode.scaleAspectFit)
        viewModel.resetPhotoScaleMode()
        XCTAssertEqual(viewModel.photoScaleMode, UIView.ContentMode.scaleAspectFill)
    }

}
