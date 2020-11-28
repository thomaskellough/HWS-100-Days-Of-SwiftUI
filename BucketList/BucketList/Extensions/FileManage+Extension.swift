//
//  FileManage+Extension.swift
//  BucketList
//
//  Created by Thomas Kellough on 11/27/20.
//

import Foundation

extension FileManager {
    var documentDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
