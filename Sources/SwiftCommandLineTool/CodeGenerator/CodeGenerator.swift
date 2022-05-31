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
        var code = datas.reduce(into: Constants.sampler) { partialResult, data in
            partialResult += """

    var \(data.key): String { \"\(data.key)\".localization }
"""
        }
        code += "\n}"

        swiftFileExporter.exportSwiftFile(
            with: code,
            fileName: Constants.fileName
        )
    }
}

extension CodeGenerator {

    enum Constants {

        static var fileName: String { "String + Localization" }
        static var variableName: String { "localization" }
        static var sampler: String {
"""
//
//  \(fileName).swift
//

import Foundation

extension String {

    var \(variableName): String {
        NSLocalizedString(self, comment: "")
    }

"""
        }
    }
}
