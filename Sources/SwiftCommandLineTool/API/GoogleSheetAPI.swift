//
//  File.swift
//  
//
//  Created by Chiaote Ni on 2022/5/30.
//

import Foundation

final class GoogleSheetAPI {

    private let key: String
    private let sheetID: String
    private let sheetName: String

    init(permissionKey: String, sheetID: String, sheetName: String) {
        self.key = permissionKey
        self.sheetID = sheetID
        self.sheetName = sheetName
    }

    func retrieveDatas(then handler: @escaping (Swift.Result<[LocalizationData], Error>) -> Void) {
        let request = makeRequest()
        URLSession.shared.dataTask(
            with: request
        ) { data, response, error in
            let decoder = JSONDecoder()
            guard let data = data else {
                handler(.failure(error!))
                return
            }
            do {
                let responseModel = try decoder.decode(SheetAPIResponseModel.self, from: data)
                handler(.success(responseModel.localizations))
            } catch {
                handler(.failure(error))
            }
        }.resume()
    }
}

extension GoogleSheetAPI {

    private func makePath() -> URL {
        let path = "https://sheets.googleapis.com/v4/spreadsheets/${{sheetID}}/values/${{sheetName}}?alt=json&key=${{key}}"
            .replacingOccurrences(of: "${{sheetID}}", with: sheetID)
            .replacingOccurrences(of: "${{sheetName}}", with: sheetName)
            .replacingOccurrences(of: "${{key}}", with: key)
        return URL(string: path)!
    }

    private func makeRequest() -> URLRequest {
        let url = makePath()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
