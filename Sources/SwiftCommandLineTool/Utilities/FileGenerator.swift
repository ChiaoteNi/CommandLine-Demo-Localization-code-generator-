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
        let rootPath: String = makeFilePath()
        contents.forEach { languageType, content in
            let folderPath = rootPath + "/\(languageType).lproj"
            let filePath = folderPath + "/Localizable.strings"
            do {
                if fileManager.fileExists(atPath: folderPath) == false {
                    try fileManager.createDirectory(
                        atPath: folderPath,
                        withIntermediateDirectories: true,
                        attributes: nil
                    )
                }
                try content.write(
                    toFile: filePath,
                    atomically: true,
                    encoding: .utf8
                )
                print("write to \(filePath) success")
            } catch {
                debugPrint("💥export localization file fail", error)
            }
        }
    }
}

// MARK: - SwiftFileExportable functions
extension FileGenerator: SwiftFileExportable {

    func exportSwiftFile(with code: String, fileName: String) {
        let filePath: String = makeFilePath(with: fileName) + ".swift"
        do {
            try code.write(
                toFile: filePath,
                atomically: true,
                encoding: .utf8
            )
            print("write to \(filePath) success")
        } catch {
            debugPrint("💥export swift file fail", error)
        }
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
