//
//  RestClient.swift
//  async
//
//  Created by Jan Stárek on 25/03/2017.
//  Copyright © 2017 Jan Stárek. All rights reserved.
//

import Foundation

class RestClient
{
    func restPost(url: URL, requestBody: String, completion: @escaping (RestResponse) -> ())
    {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = requestBody.data(using: .utf8)
        sendRequest(request: request) { response in completion(response) }
    }
    
    func restGet(url: URL, completion: @escaping (RestResponse) -> ())
    {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        sendRequest(request: request) { response in completion(response) }
    }
    
    private func sendRequest(request: URLRequest, completion: @escaping (RestResponse) -> ())
    {
        let restResponse = RestResponse()
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            if let data = data { restResponse.json = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary }
            if let response = response { restResponse.state = response as? HTTPURLResponse }
            if let error = error { restResponse.error = error as NSError }
            completion(restResponse)
        }
        task.resume()
        
    }
}
