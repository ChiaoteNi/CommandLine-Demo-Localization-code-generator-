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
    }
}
