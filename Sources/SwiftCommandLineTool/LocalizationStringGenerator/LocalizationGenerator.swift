//
//  LocalizationGenerator.swift
//  
//
//  Created by Chiaote Ni on 2022/5/31.
//

import Foundation
import AppKit

protocol LocalizationFileExportable {
    func exportLocalizationFile(with contents: [String: String])
}

final class LocalizationGenerator {

    private let localizationFileExporter: LocalizationFileExportable

    init(fileExporter: LocalizationFileExportable) {
        localizationFileExporter = fileExporter
    }

    func generateLocalizationStrings(with datas: [LocalizationData]) {
        let contents: [String: String] = datas.reduce(
            into: [:]
        ) { partialResult, data in
            data.localizedStrings
                .forEach { languageType, text in
                    let content = "\"\(data.key)\" = \"\(text)\";"
                    if let current = partialResult[languageType] {
                        partialResult[languageType] = current + "\n" + content
                    } else {
                        partialResult[languageType] = content
                    }
                }
        }
        localizationFileExporter.exportLocalizationFile(with: contents)
    }
}
