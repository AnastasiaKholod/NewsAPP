    //
    //  ServiceLayer.swift
    //

import Foundation

class ServiceLayer {
    class func request<T: Codable>(router: Router, params: [URLQueryItem] = [], completion: @escaping (Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        
        var parameters:[URLQueryItem] = []
        parameters.append(contentsOf: router.parameters)
        parameters.append(contentsOf: params)
        components.queryItems = parameters
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                return
            }
            
            if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                    print("Decoding with \(T.self) object failed, here is json pretty print \(String(decoding: jsonData, as: UTF8.self))")
                } else {
                    print("json pretty print also failed")
                }
            }
        }
        dataTask.resume()
    }
}
