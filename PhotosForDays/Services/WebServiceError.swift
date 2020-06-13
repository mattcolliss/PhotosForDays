//
//  WebServiceError.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation

// MARK: Web Service Errors
public enum WebServiceError: Error, Equatable {

    /// There was no network connection
    case noInternetError

    /// There was an NSURLError
    case networkingError

    /// The response returned a non-2xx status code
    case badResponse(statusCode: Int)

    /// The response returned a non-2xx status code, with display message from server
    case serverError(displayMessage: String)

    /// The response returned a 400 error
    case badRequest

    /// The response returned a 401 error
    case unauthorisedError

    /// The response returned a 403 error
    case forbidden

    /// The response returned a 404 error
    case notFound

    /// The response returned a 409 error
    case conflict

    /// There was an invalid response form the server
    case invalidResponse(debugDescription: String)

    /// The web servcie request was cancelled - Normally when another request of the same type is made.
    case cancelled

}
