//
//  WebServiceConfiguration.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation

private let urlSession: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
}()

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum ContentType: String {
    case json = "application/json"
}

// MARK: Config protocols
protocol WebServiceConfiguration {

    associatedtype Response: Decodable

    var baseUrl: URL { get }
    var method: HTTPMethod {get}
    var pathComponents: [String] {get}
    var queryParameters: [URLQueryItem]? { get }
    var requestBody: Data? { get }
    var contentType: ContentType { get }
    var taskIdentifier: String { get }

    var decoder: JSONDecoder { get }

    func configurationError(from statusCode: Int) throws
    func decodeResponse(data: Data) throws -> Response

}

// MARK: Default configuration
extension WebServiceConfiguration {

    var method: HTTPMethod { return .get }
    var queryParameters: [URLQueryItem]? { return nil }
    var requestBody: Data? { return nil }
    var contentType: ContentType { return .json }
    var taskIdentifier: String { return String(describing: type(of: self)) }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    func configurationError(from statusCode: Int) throws {}

    func decodeResponse(data: Data) throws -> Response {
        return try decoder.decode(Response.self, from: data)
    }

}

// MARK: Request Execution
extension WebServiceConfiguration {

    func start(completion: @escaping (Result<Response, WebServiceError>) -> Void) {

        let request = createRequest()

        let task = urlSession.dataTask(with: request) { (data, response, error) in

            let parsedResponse = self.parseResponse(data: data, response: response, error: error)

            DispatchQueue.main.sync {
                completion(parsedResponse)
            }
        }

        task.resume()

    }

    private func createRequest() -> URLRequest {

        var url = baseUrl

        //add path componentes
        for component in pathComponents {
            url = url.appendingPathComponent(component)
        }

        //add query parameters
        if let queryParameters = queryParameters, !queryParameters.isEmpty {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.queryItems = queryParameters
            url = components.url!
        }

        //create request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        //add body
        if let requestBody = requestBody {
            urlRequest.httpBody = requestBody
            urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }

    private func parseResponse(data: Data?, response: URLResponse?, error: Error?) -> Result<Response, WebServiceError> {

        //handle errors
        if let error = error as NSError? {

            if error.code == NSURLErrorNotConnectedToInternet {
                return .failure(WebServiceError.noInternetError)
            }

            if error.code == NSURLErrorCancelled {
                return .failure(WebServiceError.cancelled)
            }

            return .failure(WebServiceError.networkingError)
        }

        do {

            //validate status code
            guard let statusCode = response?.httpStatusCode else {
                return .failure(WebServiceError.invalidResponse(debugDescription: "Failed to parse HTTP status code"))
            }

            try validate(statusCode)

            guard let data = data else {
                return .failure(WebServiceError.invalidResponse(debugDescription: "Response data was nil "))
            }

            let parsedResponse = try decodeResponse(data: data)
            return .success(parsedResponse)

        } catch let requestError as WebServiceError {
            return .failure(requestError)
        } catch {
            return .failure(WebServiceError.invalidResponse(debugDescription: "\(error)"))
        }
    }

    private func validate(_ statusCode: Int) throws {

        guard statusCode >= 200 && statusCode < 300 else {

            //check for configuration specific error
            try configurationError(from: statusCode)

            switch statusCode {
            case 400:
                throw WebServiceError.badRequest
            case 401:
                throw WebServiceError.unauthorisedError
            case 403:
                throw WebServiceError.forbidden
            case 404:
                throw WebServiceError.notFound
            case 409:
                throw WebServiceError.conflict
            default:
                throw WebServiceError.badResponse(statusCode: statusCode)
            }
        }
    }
}

extension URLResponse {

    var httpStatusCode: Int? {

        guard let httpResponse = self as? HTTPURLResponse else {
            return nil
        }

        return httpResponse.statusCode

    }
}
