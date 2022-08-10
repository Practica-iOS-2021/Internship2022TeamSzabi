//
//  ChapterModel.swift
//  Internship2022TeamSzabi
//
//  Created by Andreea Laura Bogdan on 09.08.2022.
//

import Foundation

struct ChapterModel: Codable {
    var name: String?
    var documentId: String?
    var questions: [QuestionModel]?
}
