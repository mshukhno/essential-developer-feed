//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeed
//
//  Created by Mikalai Shuhno on 27/01/2025.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int {
        200
    }
    
    var isOK: Bool {
        statusCode == HTTPURLResponse.OK_200
    }
}
