//
//  MockPhotosService.swift
//  PhotosForDaysTests
//
//  Created by Matthew Colliss on 15/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation
@testable import PhotosForDays

class MockPhotosService: PhotosServiceProvider {

    let totalPages = 3

    func fetchPhotos(for date: Date, atPage page: Int, completion: @escaping (Result<GetPhotosResponseWrapper, WebServiceError>) -> Void) {

        let photo = Photo(id: "id", owner: "owner", secret: "secret", server: "server", farm: 1, title: "title")
        let photoResponse = GetPhotosResponse(page: page, pages: totalPages, photo: [photo])
        let wrapper = GetPhotosResponseWrapper(stat: "stat", photos: photoResponse)
        completion(.success(wrapper))

    }

}
