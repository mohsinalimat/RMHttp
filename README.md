# RMHttp

[![Build Status](https://travis-ci.org/rogermolas/RMHttp.svg?branch=master)](https://travis-ci.org/rogermolas/RMHttp)
![Status](https://img.shields.io/badge/status-active-brightgreen.svg?style=flat)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/rogermolas/RMHttp/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/RMHttp.svg?style=flat)](https://cocoapods.org/pods/RMHttp)
[![Version](https://img.shields.io/cocoapods/v/RMHttp.svg?style=flat)](https://cocoapods.org/pods/RMHttp)
[![Twitter](https://img.shields.io/badge/twitter-roger__molas-yellowgreen.svg)](https://www.twitter.com/roger_molas)

![RMHttp Lightweight RESTful library for iOS and watchOS](https://raw.githubusercontent.com/rogermolas/RMHttp/master/Example/Demo/Assets.xcassets/RMHttp.imageset/RMHttp.png)
RMHttp is a Lightweight REST library for iOS and watchOS.

## Features

- [x]  Chainable Request
- [x]  URL / JSON  Parameter Encoding
- [x]  HTTP Methods GET/POST/DELETE/PATCH/PUT based in  [RFC2616](https://tools.ietf.org/html/rfc2616#section-5.1.1)
- [x]  Custom Request Builder / HEADERS / PARAMETERS
- [x]  Dynamic Response Handler (JSONObject, JSONArray, String)
- [x] Codable Support
##### TODO:
- [-] Support Upload/Download resource


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

RMHttp is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RMHttp'
```

## Installation
```ruby
pod "RMHttp"
```

Run the following command in your Terminal
```bash
$ pod install
```

## Usage

##### HTPP Methods
HTTP Methods are declared in public enum `RMHttpMethod`.

`GET`, `POST` , `DELETE` , `PUT` , `PATCH`

##### Parameter Encoding
Encoding are declared in public enum `Encoding`

`URLEncoding`
`JSONEncoding`

##### Serialization
`JSONObject` - a representation of `Dictionary<String, Any>`
```swift
{
    "data" : "value",
    "isBoolean" : true,
    "list": [
        "object1",
        "object2"
    ]
}
```

`JSONArray` - a representation of `[Dictionary<String, Any>]`

```swift
[
    { "data1" : "value1"},
    { "data2" : "value2"},
    { "data3" : "value3"},
]
```

`String`
Any String respresentation (e.g HTML String, XML String, Plain Text)

##### Building Request

```swift
let params = [
"string":"Ipsum",   // String
"number": 100,      // Number
"boolean":true      // Boolean
] as [String : Any]

let urlString = "https://httpbin.org/get"
let request = RMRequest(urlString, method: .GET(.URLEncoding), parameters: params, hearders: nil)
```

##### Chained Response Handlers

###### Expecting Array object Response
```swift
RMHttp.JSON(request: request) { (response:JSONArray?, error) in
    guard error == nil else {
        self.title = "Response Error"
        self.activity.stopAnimating()
        self.textView.text = "\(err)"
        return
    }
    self.activity.stopAnimating()
    if let data = response {
        self.title = "Response Sucess"
        self.textView.text = "\(data)"
    }
}
```

###### Expecting JSON object Response
```swift
RMHttp.JSON(request: request) { (response:JSONObject?, error) in
    guard error == nil else {
        self.title = "Response Error"
        self.activity.stopAnimating()
        self.textView.text = "\(err)"
        return
    }
    self.activity.stopAnimating()
    if let data = response {
        self.title = "Response Sucess"
        self.textView.text = "\(data)"
    }
}
```

Generic method that return HTTP response has parameter  `data`  that comply to `RMHttpProtocol` (e.g JSONObject, JSONArray,  String, )
```swift
public class func JSON<T:RMHttpProtocol>(request: RMRequest, completionHandler: @escaping Handler<T>)
```

## Author

rogermolas, contact@rogermolas.com

## License


The MIT License (MIT)

Copyright (c) 2018 Roger Molas

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.





