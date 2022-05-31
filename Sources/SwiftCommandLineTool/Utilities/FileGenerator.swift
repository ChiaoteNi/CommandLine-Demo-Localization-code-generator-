//
//  FileGenerator.swift
//  
//
//  Created by Chiaote Ni on 2022/5/31.
//

import Foundation

final class FileGenerator {

    let fileManager: FileManager
    let rootPath: String

    init(
        rootPath: String,
        fileManager: FileManager = .default
    ) {
        self.rootPath = rootPath
        self.fileManager = fileManager
    }
}

// MARK: - LocalizationFileExportable functions
extension FileGenerator: LocalizationFileExportable {
    
    func exportLocalizationFile(with contents: [String : String]) {
    }
}

// MARK: - SwiftFileExportable functions
extension FileGenerator: SwiftFileExportable {

    func exportSwiftFile(with code: String, fileName: String) {
    }
}

// MARK: - Private functions
extension FileGenerator {

    private func makeFilePath(with name: String? = nil) -> String {
        let directoryPath = FileManager.default.currentDirectoryPath
        if let name = name {
            return directoryPath + "/\(rootPath)" + "/\(name)"
        } else {
            return directoryPath + "/\(rootPath)"
        }
    }
}
