//
//  RestResponse.swift
//  async
//
//  Created by Jan Stárek on 25/03/2017.
//  Copyright © 2017 Jan Stárek. All rights reserved.
//

import Foundation

class RestResponse
{
    var json: NSDictionary? = nil
    var state: HTTPURLResponse? = nil
    var error: NSError? = nil
}
