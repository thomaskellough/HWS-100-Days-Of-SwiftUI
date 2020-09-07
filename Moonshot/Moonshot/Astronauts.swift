//
//  Astronauts.swift
//  Moonshot
//
//  Created by Thomas Kellough on 9/6/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
