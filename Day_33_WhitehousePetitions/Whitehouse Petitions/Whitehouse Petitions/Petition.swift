//
//  Petition.swift
//  Whitehouse Petitions
//
//  Created by Bambang Tri Rahmat Doni on 16/10/23.
//

import Foundation

/// Parsing JSON using the Codable protocol
///
struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
