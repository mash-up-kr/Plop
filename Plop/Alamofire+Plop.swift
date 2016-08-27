//
//  Alamofire+Plop.swift
//  Plop
//
//  Created by 김혜원 on 2016. 8. 28..
//  Copyright © 2016년 seolheelee. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

extension Alamofire.Request {
    
    public func response() -> (request: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, error: NSError?) {
        let semaphore = dispatch_semaphore_create(0)
        var result: (request: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, error: NSError?)!
        
        self.response(completionHandler: { request, response, data, error in
            result = (
                request: request,
                response: response,
                data: data,
                error: error
            )
            dispatch_semaphore_signal(semaphore)
        })
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return result
    }
    
    public func responseData() -> Response<NSData, NSError> {
        let semaphore = dispatch_semaphore_create(0)
        var result: Response<NSData, NSError>!
        
        self.responseData { response in
            result = response
            dispatch_semaphore_signal(semaphore)
        }
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return result
    }
    
    public func responseJSON(options options: NSJSONReadingOptions = .AllowFragments) -> Response<AnyObject, NSError> {
        let semaphore = dispatch_semaphore_create(0)
        var result: Response<AnyObject, NSError>!
        
        self.responseJSON(options: options, completionHandler: {response in
            result = response
            dispatch_semaphore_signal(semaphore)
        })
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return result
    }
    
    public func responseString(encoding encoding: NSStringEncoding? = nil) -> Response<String, NSError> {
        let semaphore = dispatch_semaphore_create(0)
        var result: Response<String, NSError>!
        
        self.responseString(encoding: encoding, completionHandler: { response in
            result = response
            dispatch_semaphore_signal(semaphore)
        })
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return result
    }
    
    public func responsePropertyList(options options: NSPropertyListReadOptions = NSPropertyListReadOptions()) -> Response<AnyObject, NSError> {
        let semaphore = dispatch_semaphore_create(0)
        var result: Response<AnyObject, NSError>!
        
        self.responsePropertyList(options: options, completionHandler: { response in
            result = response
            dispatch_semaphore_signal(semaphore)
        })
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return result
    }
    
    public func responseObject<T: Mappable>(encoding encoding: NSStringEncoding? = nil) -> Response<T, NSError> {
        let semaphore = dispatch_semaphore_create(0)
        var result: Response<T, NSError>!
        
        self.responseObject { (response: Response<T, NSError>) -> Void in
            result = response
            dispatch_semaphore_signal(semaphore)
        }
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return result
    }
    
}