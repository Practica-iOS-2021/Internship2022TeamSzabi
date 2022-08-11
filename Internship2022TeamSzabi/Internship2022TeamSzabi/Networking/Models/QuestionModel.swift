//
//  QuestionModel.swift
//  Internship2022TeamSzabi
//
//  Created by Szabolcs Orban on 09.08.2022.
//

import Foundation

struct QuestionModel: Codable {
    var answers: [String]?
    var correctAnswer: Int?
    var question: String?
}
