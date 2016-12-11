//
//  NSLocalizedStringExtension.swift
//  WombDefender
//
//  Created by Zuheir Chikh Al Sagha on 2016-12-11.
//  Copyright © 2016 Zoko. All rights reserved.
//

import Foundation

public func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

public func NSLocalizedString(_ key: String, param1: String) -> String {
    return String.localizedStringWithFormat(NSLocalizedString(key), param1)
}

public func NSLocalizedString(_ key: String, param1: Int) -> String {
    return String.localizedStringWithFormat(NSLocalizedString(key), param1)
}
