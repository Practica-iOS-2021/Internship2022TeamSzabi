//
//  Encodable.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 8/2/22.
//

import Foundation

extension Encodable {
    var dict: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(
            with: data, options: []) as? [String: Any] else { return nil }
        return json
    }
}
