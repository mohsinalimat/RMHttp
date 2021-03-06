//
//  DestinationViewController.swift
//  RMHttp
//
//  Created by Roger Molas on 23/04/2018.
//  Copyright © 2018 Roger Molas. All rights reserved.
//

import Foundation
import UIKit

import RMHttp

// Sample Decodable Struct
struct Model: Decodable {
    var headers: objc_headers!
    var origin: String!
    var url:String!
    
    struct objc_headers: Decodable {
        var Accept: String!
        var Connection: String!
        var Host: String!
    }
}


class DestinationViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    public var type: String = ""
    
    var GET: RMRequest {
        let urlString = "https://httpbin.org/get"
        let request = RMRequest(urlString, method: .GET(.URLEncoding), parameters: nil, hearders: nil)
        return request
    }
    
    var GET_PARAMS: RMRequest {
        let params = [
            "string":"Ipsum",   // String
            "number": 100,      // Number
            "boolean":true      // Boolean
            ] as [String : Any]
        
        let urlString = "https://httpbin.org/get"
        let request = RMRequest(urlString, method: .GET(.URLEncoding), parameters: params, hearders: nil)
        return request
    }
    
    var POST: RMRequest {
        let urlString = "https://httpbin.org/post"
        let request = RMRequest(urlString, method: .POST(.URLEncoding), parameters: nil, hearders: nil)
        return request
    }
    
    var POST_PARAMS: RMRequest {
        let params = [
            "string":"Ipsum",   // String
            "number": 100,      // Number
            "boolean":true      // Boolean
            ] as [String : Any]
        
        let urlString = "https://httpbin.org/post"
        let request = RMRequest(urlString, method: .POST(.URLEncoding), parameters: params, hearders: nil)
        return request
    }
    
    var POST_JSON_BODY: RMRequest {
        let params = [
            "string":"Ipsum",   // String
            "number": 100,      // Number
            "boolean":true      // Boolean
            ] as [String : Any]
        
        let urlString = "https://httpbin.org/post"
        let request = RMRequest(urlString, method: .POST(.JSONEncoding), parameters: params, hearders: nil)
        return request
    }
    
    var DELETE: RMRequest {
        let urlString = "https://httpbin.org/delete"
        let request = RMRequest(urlString, method: .DELETE(.URLEncoding), parameters: nil, hearders:nil)
        return request
    }
    
    var GETHTMLString: RMRequest {
        let urlString = "https://httpbin.org/html"
        let request = RMRequest(urlString, method: .GET(.URLEncoding), parameters: nil, hearders: nil)
        return request
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if type == "GET" {
            reques(request: GET, expected: JSONObject())
        }
        if type == "GET with PARAMS" {
            reques(request: GET_PARAMS, expected: JSONObject())
        }

        if type == "POST" {
            reques(request: POST, expected: JSONObject())
        }
        if type == "POST with PARAMS" {
            reques(request: POST_PARAMS, expected: JSONObject())
        }
        if type == "POST JSON BODY" {
            reques(request: POST_JSON_BODY, expected: JSONObject())
        }
        
        if type == "DELETE" {
            reques(request: DELETE, expected: JSONObject())
        }
        
        if type == "STRING RESPONSE" {
            reques(request: GETHTMLString, expected: String())
        }
        
        if type == "CODABLE REQUEST" {
            reques(request: GET, model: Model.self)
        }
    }
    
    func reques<T:RMHttpProtocol>(request: RMRequest, expected: T) {
        RMHttp.isDebug = true
        RMHttp.JSON(request: request) { (response:T?, error) in
            guard error == nil else {
                self.title = "Response Error"
                self.activity.stopAnimating()
                if let err = error {
                    self.textView.text = "\(err)"
                }
                return
            }
            if let data = response {
                self.title = "Response Sucess"
                self.textView.text = "\(data)"
            }
            self.activity.stopAnimating()
        }
    }
    
    func reques<T:Decodable>(request: RMRequest, model: T.Type) {
        RMHttp.isDebug = true
        RMHttp.JSON(request: request, model: model) { (response:T?, error) in
            guard error == nil else {
                self.title = "Response Error"
                self.activity.stopAnimating()
                if let err = error {
                    self.textView.text = "\(err)"
                }
                return
            }
            if let data = response as? Model {
                self.title = "Response Sucess"
                self.textView.text = """
                    \(data.origin!)
                    \(data.url!)
                    \(data.headers.Connection!)
                    \(data.headers.Accept!)
                    \(data.headers.Host!)
                """
            }
            self.activity.stopAnimating()
        }
    }
}
