//
//  GetPhotosConfiguration.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation

struct GetPhotosConfiguration: WebServiceConfiguration {

    let date: Date
    let page: Int

    typealias Response = GetPhotosResponseWrapper

    var baseUrl: URL {
        return flickrApiBaseUrl
    }

    var pathComponents: [String] {
        return ["services", "rest"]
    }

    var queryParameters: [URLQueryItem]? {
        return [
            URLQueryItem(name: "method", value: "flickr.interestingness.getList"),
            URLQueryItem(name: "api_key", value: flickrApiKey),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
            URLQueryItem(name: "date", value: DateFormatter.apiRequestFormatter.string(from: date)),
            URLQueryItem(name: "page", value: String(page))
        ]
    }

}

struct GetPhotosResponseWrapper: Decodable {
    let stat: String
    let photos: GetPhotosResponse
}

struct GetPhotosResponse: Decodable {
    let page: Int
    let pages: Int
    let photo: [Photo]
}
