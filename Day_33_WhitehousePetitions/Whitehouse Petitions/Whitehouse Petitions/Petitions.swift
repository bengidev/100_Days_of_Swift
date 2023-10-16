//
//  Petitions.swift
//  Whitehouse Petitions
//
//  Created by Bambang Tri Rahmat Doni on 16/10/23.
//

import Foundation

/// Parsing JSON using the Codable protocol
///
struct Petitions: Codable {
    var results: [Petition]
}
