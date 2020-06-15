//
//  PhotosService.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 15/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation

protocol PhotosServiceProvider {
    func fetchPhotos(for date: Date, atPage page: Int, completion: @escaping (Result<GetPhotosResponseWrapper, WebServiceError>) -> Void)
}

class PhotosService: PhotosServiceProvider {

    func fetchPhotos(for date: Date, atPage page: Int, completion: @escaping (Result<GetPhotosResponseWrapper, WebServiceError>) -> Void) {
        GetPhotosConfiguration(date: date, page: page).start(completion: completion)
    }

}
