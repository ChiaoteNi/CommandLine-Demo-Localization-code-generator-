//
//  Configs.swift
//  
//
//  Created by Chiaote Ni on 2022/5/30.
//

import Foundation

enum Environments {

    enum Keys: String {
        case model_export_path
        case localization_export_path
        case sheetName
        case sheetID
        case permission_key
    }

    static subscript(_ key: Keys) -> String? {
        get { getEnv(key.rawValue) }
        set { setenv(key.rawValue, newValue, 1) }
    }

    static func loadFromURL(_ url: URL) throws {
        let data = try Data(contentsOf: url)
        guard let content = String(bytes: data, encoding: .utf8) else { return }
        content
            .components(separatedBy: "\n")
            .forEach { element in
                let sets = element.components(separatedBy: " = ")
                setenv(sets[0], sets[1], 1)
            }
    }

    private static func getEnv(_ key: String) -> String? {
        if let rawValue = getenv(key) {
            return String(utf8String: rawValue)
        } else {
            return nil
        }
    }
}
