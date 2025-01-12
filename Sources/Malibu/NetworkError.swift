import Foundation

public enum NetworkError: Error {
    case invalidRequestURL
    case missingContentType(response: Response)
    case invalidParameter
    case noDataInResponse
    case noResponseReceived
    case unacceptableStatusCode(statusCode: Int, response: Response)
    case unacceptableContentType(contentType: String, response: Response)
    case jsonArraySerializationFailed(response: Response)
    case jsonDictionarySerializationFailed(response: Response)
    case stringSerializationFailed(encoding: UInt, response: Response)
    case responseDecodingFailed(type: Decodable.Type, response: Response)

    public var reason: String {
        var text: String

        switch self {
        case .invalidRequestURL:
            text = "Invalid request URL"
        case .missingContentType:
            text = "Response content type was missing"
        case .invalidParameter:
            text = "Parameter is not convertible to NSData"
        case .noDataInResponse:
            text = "No data in response"
        case .noResponseReceived:
            text = "No response received"
        case let .unacceptableStatusCode(statusCode, _):
            text = "Response status code \(statusCode) was unacceptable"
        case let .unacceptableContentType(contentType, _):
            text = "Response content type \(contentType) was unacceptable"
        case .jsonArraySerializationFailed:
            text = "No JSON array in response data"
        case .jsonDictionarySerializationFailed:
            text = "No JSON dictionary in response data"
        case let .stringSerializationFailed(encoding, _):
            text = "String could not be serialized with encoding: \(encoding)"
        case let .responseDecodingFailed(type, _):
            text = "Response could not be decoded into \(type)"
        }

        return NSLocalizedString(text, comment: "")
    }
}

// MARK: - Hashable

extension NetworkError: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(reason.hashValue)
    }
}

// MARK: - Equatable

public func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
    return lhs.reason == rhs.reason
}

// MARK: - NSError

extension NSError {
    var isOffline: Bool {
        return Int32(code) == CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue
    }
}
