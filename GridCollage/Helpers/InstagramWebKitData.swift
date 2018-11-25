//
//  InstagramService.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 10/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import WebKit

class InstagramWebKitData {
    static func remove() {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            for record in records {
                if record.displayName.contains("instagram") {
                    dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(),
                                         for: [record], completionHandler: {})
                }
            }
        }
    }
}
