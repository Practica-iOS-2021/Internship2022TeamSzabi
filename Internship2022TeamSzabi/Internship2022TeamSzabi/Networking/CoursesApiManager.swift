//
//  CoursesApiManager.swift
//  Internship2022TeamSzabi
//
//  Created by Andreea Laura Bogdan on 08.08.2022.
//

import Foundation
import FirebaseFirestore

class CoursesApiManager {
    static let sharedCoursesData = CoursesApiManager()
    
    
    func fetchCoursesData(completion: @escaping ([CoursesModel]?) -> Void) {
    let coursesRefrence = FirestoreManager.dbConn.collection(coursesCollection)
    
        coursesRefrence.getDocuments { querySnapshot, err in
            if err != nil {
               completion(nil)
            } else {
                var courses: [CoursesModel] = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let semester = data["semester"] as? Int ?? 0
                    let chapters = data["chapters"] as? [ChapterModel] ?? []
                    let currentCourse = CoursesModel(name: name, semester: semester, chapters: chapters)
                    courses.append(currentCourse)
                }
                completion(courses)
            }
        }
    }
}
