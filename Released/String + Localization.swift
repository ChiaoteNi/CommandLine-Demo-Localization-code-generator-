//
//  String + Localization.swift
//

import Foundation

extension String {

    var localization: String {
        NSLocalizedString(self, comment: "")
    }

    var btn_product_name: String { "btn_product_name".localization }
    var btn_product_description: String { "btn_product_description".localization }
    var btn_purchase: String { "btn_purchase".localization }
    var btn_cancel: String { "btn_cancel".localization }

    func btn_blabvlabl(_ value: Int) -> String {
        "dddgfg\(value)"
    }
}
