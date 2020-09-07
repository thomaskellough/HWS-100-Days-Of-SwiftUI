//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Thomas Kellough on 9/6/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation

extension Bundle {
    func decode(_ file: String) -> [Astronaut] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to load \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to convert \(file) to data from bundle")
        }
        
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode([Astronaut].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
