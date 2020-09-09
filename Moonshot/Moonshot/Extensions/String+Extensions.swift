//
//  String+Extensions.swift
//  Moonshot
//
//  Created by Thomas Kellough on 9/8/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation

extension String {
    func replacingFirstOccurrence(of target: String, with replacement: String) -> String {
        guard let range = self.range(of: target) else { return self }
        return self.replacingCharacters(in: range, with: replacement)
    }
}
