//
//  Person.swift
//  Names To Faces
//
//  Created by Bambang Tri Rahmat Doni on 20/10/23.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
