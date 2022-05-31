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
retrieveLocalizationData { datas in
}
