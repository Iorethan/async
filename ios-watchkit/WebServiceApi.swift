//
//  WebServiceApi.swift
//  async
//
//  Created by Jan Stárek on 25/03/2017.
//  Copyright © 2017 Jan Stárek. All rights reserved.
//

import Foundation

class WebServiceApi
{
    let restClient = RestClient()
    let url = URL(string: "https://private-9d572-asynchronoustasks.apiary-mock.com/basic")

    
    func getSupportedLanguages(completion: @escaping ([String]?) -> ())
    {
        restClient.restGet(url: url!)
        {
            response in
            let languages = self.parseResponseToLanguages(response: response)
            if languages != nil { completion(languages) }
            else { completion(nil) }
        }
    }
    
    func postSupportedLanguages(completion: @escaping ([String]?) -> ())
    {
        let request = "{\n  \"_session\": \"demo\",\n  \"credentials\": {\n    \"username\": \"demo\",\n    \"password\": \"demo\"\n  }\n}"
        restClient.restPost(url: url!, requestBody: request)
        {
            response in
            let languages = self.parseResponseToLanguages(response: response)
            if languages != nil { completion(languages) }
            else { completion(nil) }
        }
    }
    
    private func parseResponseToLanguages(response: RestResponse) -> [String]?
    {
        if response.json != nil
        {
            if let dictionary = response.json as? [String: Any]
            {
                if dictionary["supported"] != nil
                {
                    if let supported = dictionary["supported"] as? [String]
                    {
                        return supported
                    }
                }
            }
        }
        return nil
    }
}
