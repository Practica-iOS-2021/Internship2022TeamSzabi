//
//  GradesApiManager.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 8/10/22.
//

import Foundation

class GradesApiManager {
    static let sharedGradesData = GradesApiManager()
    
    func getGradesForUser(completion: @escaping ([GradeModel]?) -> Void) {
        guard let uid = FirestoreManager.auth.currentUser?.uid else {
            completion(nil)
            return
        }
        let userReference = FirestoreManager.dbConn.collection(usersCollection).document(uid)
        let usersGradesReference = userReference.collection(gradesCollection)
        
        usersGradesReference.getDocuments { querySnapshot, err in
            if err != nil {
                completion(nil)
            } else {
                var grades: [GradeModel] = []
                querySnapshot?.documents.forEach { document in
                    let data = document.data()
                    let chapter = data["chapter"] as? String ?? ""
                    let course = data["course"] as? String ?? ""
                    let grade = data["grade"] as? Double ?? 0.0
                    let semester = data["semester"] as? Int ?? 1
                    
                    let newGrade = GradeModel(chapter: chapter, course: course, grade: grade, semester: semester)
                    grades.append(newGrade)
                }
                completion(grades)
            }
        }
    }
    
    func saveGradeForUser(newGrade: GradeModel, completion: @escaping (Bool, String?) -> Void) {
        guard let uid = FirestoreManager.auth.currentUser?.uid else {
            completion(false, "Failed to get user's uid")
            return
        }
        guard let newGradeData = newGrade.dict else {
            completion(false, "Unable to encode grade")
            return
        }
        let userReference = FirestoreManager.dbConn.collection(usersCollection).document(uid)
        let usersGradesReference = userReference.collection(gradesCollection)
        let newGradeDocument = usersGradesReference.document()
        
        newGradeDocument.setData(newGradeData)
        completion(true, nil)
    }
}
