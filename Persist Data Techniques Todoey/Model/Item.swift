//
//  Item.swift
//  Persist Data Techniques Todoey
//
//  Created by Ajinkya Sonar on 07/09/18.
//  Copyright © 2018 Ajinkya Sonar. All rights reserved.
//

import Foundation

// Rather than Encodable and Decodeable use Codable

class Item: Codable {
    
    var isChecked = Bool()
    var title = String()
    
}
