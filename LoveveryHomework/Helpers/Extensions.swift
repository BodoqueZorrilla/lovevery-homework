//
//  Extensions.swift
//  LoveveryHomework
//
//  Created by Sergio Eduardo Zorilla Arellano on 09/04/24.
//

import Foundation

extension String {
    func toDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                return json
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                return nil
            }
        } else {
            print("Error converting string to data")
            return nil
        }
    }
}
