//
//  RMRequest.swift
//  RMHttp
//
//  Created by Roger Molas on 12/04/2018.
//  Copyright © 2018 Roger Molas. All rights reserved.
//

import Foundation

open class RMRequest {
    public var urlRequest:URLRequest!
    public var url:URL!
    public var parameters:[String : Any]? = nil
    public var allHeaders:[String : String]? = nil
    public var sessionConfig:URLSessionConfiguration!
    public var restrictStatusCodes:Set<Int> = []  // e.g 404, 500, return Error
    
    public var timeoutIntervalForRequest: TimeInterval = 30
    public var timeoutIntervalForResource: TimeInterval = 30
    public var httpMaximumConnectionsPerHost: Int = 1
    
    private func defaulSessionConfig() {
        sessionConfig = URLSessionConfiguration.default
        sessionConfig.allowsCellularAccess = true // use cellular data
        sessionConfig.timeoutIntervalForRequest = timeoutIntervalForRequest // timeout per request
        sessionConfig.timeoutIntervalForResource = timeoutIntervalForResource // timeout per resource access
        sessionConfig.httpMaximumConnectionsPerHost = httpMaximumConnectionsPerHost // connection per host
    }
    
    public init(urlString: String,
                method: RMHttpMethod<Encoding>,
                parameters: [String : Any]!,
                hearders: [String : String]!) {
        
        self.url = URL(string: urlString)
        self.urlRequest = URLRequest(url: url!)
        self.setHttp(method: method)
        self.setHttp(hearders: hearders)
        self.set(parameters: parameters, method: method)
        defaulSessionConfig()
    }
    
    // -
    public init(url: URL) {
        self.url = url
        self.urlRequest = URLRequest(url: url)
        defaulSessionConfig()
    }
    
    // Url cachePolicy
    public init(url: URL, cachePolicy: URLRequest.CachePolicy, timeoutInterval: TimeInterval) {
        self.url = url
        self.urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeoutInterval)
        defaulSessionConfig()
    }
    
    // Set and append parameters to base URL
    public func set(parameters: [String : Any]!, method: RMHttpMethod<Encoding>) {
        self.parameters = (parameters != nil) ? parameters : [String:Any]()
        let request = RMBuilder().build(request: urlRequest, parameter: parameters, method: method)
        self.urlRequest = request
    }
    
    // Assign http Method
    public func setHttp(method: RMHttpMethod<Encoding>) {
        self.urlRequest.httpMethod = method.httpMethod
    }
    
    // Assign all headers
    public func setHttp(hearders: [String : String]!){
        self.allHeaders = hearders
        if let mHeaders = hearders {
            for (field, value) in mHeaders {
                self.setValue(value: value, headerField: field)
            }
        }
    }
    
    // Manual assign value to header
    public func setValue(value: String, headerField: String) {
        self.urlRequest.setValue(value, forHTTPHeaderField: headerField)
    }
    
    // Custom Session config
    public func setSession(config: URLSessionConfiguration) {
        sessionConfig = config
    }
}

extension RMRequest: CustomStringConvertible {
    public var description: String {
        var desc: [String] = []
        if let request = urlRequest {
            desc.append("\(String(describing: request.url?.absoluteString))")
        }
        if let mParameters = parameters {
            desc.append("\(mParameters)")
        }
        if let mAllHeaders = allHeaders {
            desc.append("\(mAllHeaders)")
        }
        return desc.joined(separator: " : ")
    }
}
