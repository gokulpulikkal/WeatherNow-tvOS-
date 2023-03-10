//
//  ServiceManager.swift
//  WeatherNow
//
//  Created by Gokul P on 11/02/23.
//

import Foundation

public class ServiceManager {
    
    public static let shared = ServiceManager()
    
    func callService<T: Decodable>(urlString: String,
                                   method: HTTPMethod,
                                   headers: [String: String]? = nil,
                                   success: @escaping (T)->(),
                                   fail: @escaping (HTTPError)->()) -> URLSessionDataTask? {
        
        guard let urlObj = URL(string: urlString) else {
            fail(.requestError)
            return nil
        }
        var request = URLRequest(url: urlObj)
        request.httpMethod = method.rawValue
        
        let config = URLSessionConfiguration.default
        
        if let headers = headers {
            config.httpAdditionalHeaders = headers
        }
        let urlSession = URLSession.init(configuration: config)
        
        let task: URLSessionDataTask = urlSession.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    fail(.noData)
                    return
                }
                
                let decoder = JSONDecoder()
                if let json = try? decoder.decode(T.self, from: data) {
                    success(json)
                } else {
                    fail(.parsingFailed)
                }
            }
        }
        task.resume()
        return task
    }
}
