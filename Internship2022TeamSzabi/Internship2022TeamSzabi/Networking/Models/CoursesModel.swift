//
//  CoursesModel.swift
//  Internship2022TeamSzabi
//
//  Created by Andreea Laura Bogdan on 09.08.2022.
//

import Foundation

struct CoursesModel: Codable {
    var name: String?
    var semester: Int?
    var documentId: String?
    var chapters: [ChapterModel]?
}
