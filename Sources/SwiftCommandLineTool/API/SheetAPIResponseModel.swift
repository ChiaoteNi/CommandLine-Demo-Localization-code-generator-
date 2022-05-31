//
//  SheetAPIResponseModel.swift
//  
//
//  Created by Chiaote Ni on 2022/5/31.
//

import Foundation

struct SheetAPIResponseModel: Decodable {

    private enum CodingKeys: String, CodingKey {
        case values
    }

    let localizations: [LocalizationData]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var values = try container.nestedUnkeyedContainer(forKey: .values)

        var localizations: [LocalizationData] = []
        var titles = try values.decode([String].self)
        titles = titles
            .enumerated()
            .reduce(into: [String](), { partialResult, element in
                guard element.offset > 0 else { return }
                let localizationKey = element
                    .element
                    .components(separatedBy: "_")
                    .last!
                partialResult.append(localizationKey)
            })

        while values.isAtEnd == false {
            var strings = try values.decode([String].self)
            let key = strings.removeFirst()
            let localizedStrings = strings
                .enumerated()
                .reduce(into: [String: String]()) { partialResult, element in
                    let key = titles[element.offset]
                    partialResult[key] = element.element
                }
            let localization = LocalizationData(
                key: key,
                localizedStrings: localizedStrings
            )
            localizations.append(localization)
        }
        self.localizations = localizations
    }
}
