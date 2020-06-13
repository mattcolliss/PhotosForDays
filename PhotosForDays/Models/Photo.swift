//
//  Photo.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation

struct Photo: Decodable, Hashable {

    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String

    // Flickr Photo URL form: https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
    var url: URL? {
        let urlString = String(format: flickrPhotoUrlFormat, String(farm), server, id, secret)
        return URL(string: urlString)
    }

}
