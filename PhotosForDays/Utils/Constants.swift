//
//  Constants.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation

// Flickr API
let flickrApiBaseUrl = URL(string: "https://www.flickr.com")!
let flickrApiKey = "e45c170dab0e8894f1fd0624af1de35c"
let flickrPhotoUrlFormat = "https://farm%1$@.staticflickr.com/%2$@/%3$@_%4$@.jpg"

// State Restoration
let selectDateActivityType = "com.collissions.PhotosForDays.selectDate"
let selectPhotoActivityType = "com.collissions.PhotosForDays.selectPhoto"
