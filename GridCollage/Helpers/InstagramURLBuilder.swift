//
//  URLBuilder.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 28/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation

class InstagramURLBuilder {
    
    private static let serverURLStirng = "https://instagram.com"
    
    static let redirectHost = "subdan.ru"
    
    static func getAuthURL() -> URL? {
        var components = URLComponents(string: "https://api.instagram.com/oauth/authorize")
        let clientID = URLQueryItem(name: "client_id", value: "<#api_key#>")
        let redirectURI = URLQueryItem(name: "redirect_uri", value: "https://subdan.ru/oauth")
        let responseType = URLQueryItem(name: "response_type", value: "token")
        components?.queryItems = [clientID, redirectURI, responseType]
        return components?.url
    }
    
    static func getRecentMediaURL(accessToken: String) -> URL? {
        var components = URLComponents(string: "https://api.instagram.com/v1/users/self/media/recent/")
        let accessToken = URLQueryItem(name: "access_token", value: accessToken)
        components?.queryItems = [accessToken]
        return components?.url
    }
    
}
