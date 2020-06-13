//
//  Photo.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
}
