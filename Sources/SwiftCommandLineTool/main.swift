import Foundation

print("Hello, world!")


func configureEnvironment() throws {
    guard var configFileURL = Process().currentDirectoryURL else { return }
    configFileURL.appendPathComponent("./Config")
    try Environments.loadFromURL(configFileURL)
}

func retrieveLocalizationData(then handler: @escaping ([LocalizationData]?) -> Void) {
    guard
        let permissionKey = Environments[.permission_key],
        let sheetID = Environments[.sheetID],
        let sheetName = Environments[.sheetName]
    else {
        handler(nil)
        return
    }
    let api = GoogleSheetAPI(
        permissionKey: permissionKey,
        sheetID: sheetID,
        sheetName: sheetName
    )
    api.retrieveDatas { result in
        switch result {
        case .success(let models):
            handler(models)
        case .failure(let error):
            debugPrint("🤢", error)
            handler(nil)
        }
    }
}

try configureEnvironment()

let semaphore = DispatchSemaphore(value: 0)
retrieveLocalizationData { datas in
    guard let datas = datas else {
        semaphore.signal()
        return
    }
    let codeExporter = FileGenerator(rootPath: Environments[.model_export_path] ?? ".")
    let codeGenerator = CodeGenerator(fileExporter: codeExporter)
    codeGenerator.generateExtensionCode(with: datas)

    let localizationExporter = FileGenerator(rootPath: Environments[.localization_export_path] ?? ".")
    let localizationGenerator = LocalizationGenerator(fileExporter: localizationExporter)
    localizationGenerator.generateLocalizationStrings(with: datas)
    semaphore.signal()
}
semaphore.wait()
