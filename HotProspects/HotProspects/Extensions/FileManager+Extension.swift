//
//  FileManager+Extension.swift
//  HotProspects
//
//  Created by Thomas Kellough on 12/12/20.
//

import Foundation

extension FileManager {
    var documentDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
