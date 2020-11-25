//
//  NetworkManager.swift
//  Milestone 10-12 Friendface
//
//  Created by Thomas Kellough on 11/22/20.
//

import Foundation

public class Networking {
    
    let friendURL = "https://www.hackingwithswift.com/samples/friendface.json"
    
    enum NetworkError: Error {
        case badUrl
        case serverError
        case alreadyExists
        case canceledRequest
    }
    
    func makeGetRequest(completion: @escaping (Result<Data, NetworkError>) -> Void) {
        if let url = URL(string: friendURL) {
            var request = URLRequest(url: url)
            request.timeoutInterval = 180
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, let response = response as? HTTPURLResponse else {
                    if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                        completion(.failure(.canceledRequest))
                        return
                    }
                    completion(.failure(.serverError))
                    return
                }
                
                guard (200 ... 299) ~= response.statusCode else {
                    completion(.failure(.serverError))
                    return
                }
                
                completion(.success(data))
            }.resume()
        }
    }
}
