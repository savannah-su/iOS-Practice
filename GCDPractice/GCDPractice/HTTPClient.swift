//
//  HTTP.swift
//  GCDPractice
//
//  Created by Savannah Su on 2020/1/14.
//  Copyright © 2020 Savannah Su. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    
    case GET
    
    case POST
}

protocol RequestMaker {
    
    var header: [String: String]? { get }
    
    var body: Data? { get }
    
    var method: String { get }
    
    var endPoint: Int { get }
}

extension RequestMaker {
    
    func makeRequest() -> URLRequest {
        
        let urlString = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=5012e8ba-5ace-4821-8482-ee07c147fd0a&limit=1&offset=\(endPoint)"
        
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        
        request.allHTTPHeaderFields = header
        
        request.httpBody = body
        
        request.httpMethod = method
        
        return request
    }
}

enum SpeedRequest: RequestMaker {
    
    case zeroOffset
    
    case tenOffset
    
    case twentyOffset
    
    var header: [String : String]? {
        switch self {
        case .zeroOffset, .tenOffset, .twentyOffset: return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .zeroOffset, .tenOffset, .twentyOffset: return nil
        }
    }
    
    var method: String {
        switch self {
        case .zeroOffset, .tenOffset, .twentyOffset: return HTTPMethod.GET.rawValue
        }
    }
    
    var endPoint: Int {
        switch self {
        case .zeroOffset: return 0
        case .tenOffset: return 10
        case .twentyOffset: return 20
        }
    }
}

class speedDataManager {
    
    func getSpeedData(index: Int, completion: @escaping (SpeedData) -> Void) {
        
        var offsetRequest: URLRequest?
        
        switch index {
            
        case 0: offsetRequest = SpeedRequest.makeRequest(SpeedRequest.zeroOffset)()
        case 1: offsetRequest = SpeedRequest.makeRequest(SpeedRequest.tenOffset)()
        case 2: offsetRequest = SpeedRequest.makeRequest(SpeedRequest.twentyOffset)()
        
        default: return
        }
        
        //URLSession queue(operation queue)最大連接數量default = 1(serial queue)，不把值改大只能前一個完成才能執行下一個
        URLSession.shared.delegateQueue.maxConcurrentOperationCount = 10
        
        URLSession.shared.dataTask(with: offsetRequest!) { (data, response, error) in
            
            guard error == nil else {
                
                print(error!)
                
                return
            }
            
            guard let httpResponse =  response as? HTTPURLResponse else {
                
                print("Downcast HTTPURLResponse fail")
                
                return
            }
                
            guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                
                print(httpResponse.statusCode)
                
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                
                let result = try decoder.decode(SpeedData.self, from: data!)
                
                completion(result)
                
            } catch {
                print(error)
            }
            
        }.resume()
        
        print(12345)
        /*
         先print12345才會跑api。
         因為{ (data, response, error) in...}為一closure/async概念。
         在呼叫func getSpeedData時，會先print(12345)，再回去做其他事，等api打完資料拿到了才會顯示。
         */
    }
}
