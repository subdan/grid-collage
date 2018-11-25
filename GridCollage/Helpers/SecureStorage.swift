//
//  SecureStorage.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 29/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation

class SecureStorage {
    
    func saveAccessToken(_ accessToken: String) {
        let data = accessToken.data(using: String.Encoding.utf8)!
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: "instagram.com",
                                    kSecValueData as String: data]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            print("[SecureStorage] accessToken successfully added to the Keychain")
        } else {
            print("[SecureStorage] Unable to save accessToken to the Keychain")
        }
    }
    
    func deleteAccessToken() {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: "instagram.com"]
        let status = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            print("[SecureStorage] Successfully deleted accessToken")
        } else if status == errSecItemNotFound {
            print("[SecureStorage] accessToken not found in the Keychain")
        } else {
            print("[SecureStorage] Unable to delete accessToken")
        }
    }
    
    func getAccessToken() -> String? {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrServer as String: "instagram.com",
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecItemNotFound {
            print("[SecureStorage] accessToken not found")
            return nil
        } else if status == errSecSuccess {
            if let existingItem = item as? [String : Any],
                let accessTokenData = existingItem[kSecValueData as String] as? Data,
                let accessToken = String(data: accessTokenData, encoding: String.Encoding.utf8)
            {
                print("[SecureStorage] accessToken found")
                return accessToken
            }
            else
            {
                print("[SecureStorage] Unexpected accessToken data")
                return nil
            }
        } else {
            print("[SecureStorage] Unhandled Keychain error")
            return nil
        }
    }
}
