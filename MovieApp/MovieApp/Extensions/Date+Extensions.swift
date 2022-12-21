//
//  Date+Extensions.swift
//  MovieApp
//
//  Created by Andreea A on 21.12.2022.
//

import Foundation

extension Date {
    func asFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
}
