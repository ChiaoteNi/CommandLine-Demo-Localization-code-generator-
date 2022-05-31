//
//  File.swift
//  
//
//  Created by Chiaote Ni on 2022/5/31.
//

import Foundation

protocol SwiftFileExportable {
    func exportSwiftFile(with code: String, fileName: String)
}

final class CodeGenerator {

    private let swiftFileExporter: SwiftFileExportable

    init(fileExporter: SwiftFileExportable) {
        swiftFileExporter = fileExporter
    }

    func generateExtensionCode(with datas: [LocalizationData]) {
    }
}

extension CodeGenerator {

    enum Constants {
    }
}
