//
//  NetworkHelper.swift
//

import Foundation
import Alamofire

class NetworkHelper: NSObject {
    fileprivate let url = "https://gnews.io"
    static let token = "b374470e3362515c855f32de7dd466dd"
    
    func get(method: String, params: [String: String]?, headers: [String: String]?, success: @escaping (Any) -> Void, error: (()->Void)?) {
        self.get(method: method, params: params, headers: headers, success: success, failure: error)
    }
    
    func get(method: String, params: [String:String]?, headers: [String:String]?, success: @escaping (Any?) -> Void, failure: (() -> Void)?) {
        
        let url = self.url(method: method, params: params)
        AF.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: HTTPHeaders(headers ?? [:])).responseData { result in
    
            if let jsonData = result.value {
                success(jsonData)
            } else if let failure = failure {
                print("FAILURE: ")
                print(result.error as Any)
                failure()
            }
        }
    }
    
    // MARK: - Private
    fileprivate func url(method: String, params: [String: String]?) -> String {
        var url = self.url + method
        
        url += "?"
        if let params = params, params.keys.count > 0 {
            for key in params.keys {
                if let value = params[key] {
                    url += key + "=" + value + "&"
                }
            }
        }
        
        if let url = url.substring(to: url.length - 1) {
            return url
        }
        
        return url
    }
}

//MARK: -  helpers and handlers
extension NetworkHelper {
    private func getNetworkError(error: Error?) -> NetworkError {
        if let error = error as? AFError {
            switch error {
            case .invalidURL(let url):
                print("invalidURL \(url)")
            case .parameterEncodingFailed(let reason):
                print("parameterEncodingFailed - \(reason)")
            case .multipartEncodingFailed(let reason):
                print("multipartEncodingFailed \(reason)")
            case .responseValidationFailed(let reason):
                switch reason {
                case .customValidationFailed(error: let error):
                    print("dataFileReadFailed \(error)")
                case .dataFileNil:
                    print("dataFileNil")
                case .dataFileReadFailed(let at):
                    print("dataFileReadFailed \(at)")
                case .missingContentType(let acceptableContentTypes):
                    print("missingContentType \(acceptableContentTypes)")
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    print("acceptableContentTypes \(acceptableContentTypes)\nresponseContentType \(responseContentType)")
                case .unacceptableStatusCode(let code):
                    print("unacceptableStatusCode \(code)")
                }
                
                return .technicalErrorOnClientSide
            case .responseSerializationFailed(let reason):
                switch reason {
                case .inputDataNilOrZeroLength:
                    print("inputDataNilOrZeroLength")
                case .inputFileNil:
                    print("inputFileNil")
                case .inputFileReadFailed(let at):
                    print("inputFileReadFailed \(at)")
                case .stringSerializationFailed(let encoding):
                    print("stringSerializationFailed \(encoding)")
                case .jsonSerializationFailed(let error):
                    print("jsonSerializationFailed \(error)")
                case .decodingFailed(error: let error):
                    print("decodingFailed \(error)")
                case .customSerializationFailed(error: let error):
                    print("customSerializationFailed \(error)")
                case .invalidEmptyResponse(type: let type):
                    print("invalidEmptyResponse \(type)")
                }
                
                return .errorParsingJson
            case .createUploadableFailed(error: let error):
                print("createUploadableFailed \(error)")
            case .createURLRequestFailed(error: let error):
                print("createURLRequestFailed \(error)")
            case .downloadedFileMoveFailed(error: let error, source: _, destination: _):
                print("downloadedFileMoveFailed \(error)")
            case .explicitlyCancelled:
                print("explicitlyCancelled")
            case .parameterEncoderFailed(reason: let reason):
                print("parameterEncoderFailed \(reason)")
            case .requestAdaptationFailed(error: let error):
                print("requestAdaptationFailed \(error)")
            case .requestRetryFailed(retryError: _, originalError: let originalError):
                print("requestRetryFailed \(originalError)")
            case .serverTrustEvaluationFailed(reason: let reason):
                print("serverTrustEvaluationFailed \(reason)")
            case .sessionDeinitialized:
                print("sessionDeinitialized")
            case .sessionInvalidated(error: let error):
                print("sessionInvalidated \(error?.localizedDescription ?? "")")
            case .sessionTaskFailed(error: let error):
                print("sessionTaskFailed \(error)")
            case .urlRequestValidationFailed(reason: let reason):
                print("urlRequestValidationFailed \(reason)")
            }
        } else if let error = error as? URLError {
            if error.code == .networkConnectionLost || error.code == .notConnectedToInternet {
                return .networkIsUnavailable
            } else if error.code == .cannotFindHost || error.code == .cannotConnectToHost {
                return .serverIsUnavailable
            } else if error.code == .timedOut {
                return .requestTimedOut
            }
            
            print(error)
        } else {
            print("Unknown error")
        }
        
        return NetworkError.unknown
    }
}


