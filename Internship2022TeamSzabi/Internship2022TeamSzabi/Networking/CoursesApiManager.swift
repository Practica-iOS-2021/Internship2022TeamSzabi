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
    
    private var courses: [CoursesModel] = []
    
    func getCoursesData(completion: @escaping ([CoursesModel]?) -> Void) {
        if !courses.isEmpty {
            completion(courses)
        }
        let coursesReference = FirestoreManager.dbConn.collection(coursesCollection)
        
        coursesReference.getDocuments { [weak self] querySnapshot, error in
            if error != nil {
                completion(nil)
            } else {
                guard let self = self else { return }
                var courses: [CoursesModel] = []
                for document in querySnapshot?.documents ?? [] {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let semester = data["semester"] as? Int ?? 0
                    
                    let currentCourse = CoursesModel(name: name, semester: semester, documentId: document.documentID)
                    courses.append(currentCourse)
                }
                self.courses = courses
                self.getAllCourses {
                    completion(self.courses)
                }
            }
        }
    }
    
    private func getAllCourses(completion: @escaping () -> Void) {
        for course in courses {
            getChapters(courseDocumentId: course.documentId ?? "") { chapters in
                if course.documentId == self.courses.last?.documentId {
                    completion()
                }
                for chapter in chapters ?? [] {
                    self.getQuestions(courseDocumentId: course.documentId ?? "",
                                      chapterDocumentId: chapter.documentId ?? "")
                }
            }
        }
    }
    
    private func getChapters(courseDocumentId: String,
                             completion: @escaping ([ChapterModel]?) -> Void) {
        let coursesRefrence = FirestoreManager.dbConn.collection(coursesCollection)
        let chaptersRefrence = coursesRefrence.document(courseDocumentId).collection(chaptersCollection)
        
        chaptersRefrence.getDocuments { [weak self] querySnapshot, error in
            if error != nil {
                completion(nil)
            } else {
                var chapters: [ChapterModel] = []
                for document in querySnapshot?.documents ?? [] {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let chapter = ChapterModel(name: name,
                                               documentId: document.documentID)
                    
                    chapters.append(chapter)
                }
                self?.updateCourse(documentId: courseDocumentId, chapters: chapters)
                completion(chapters)
            }
        }
    }
    
    private func getQuestions(courseDocumentId: String,
                              chapterDocumentId: String) {
        let coursesRefrence = FirestoreManager.dbConn.collection(coursesCollection)
        let chaptersRefrence = coursesRefrence.document(courseDocumentId).collection(chaptersCollection)
        let questionRefrence = chaptersRefrence.document(chapterDocumentId).collection(questionsCollection)
        
        questionRefrence.getDocuments { [weak self] querySnapshot, _ in
            var questions: [QuestionModel] = []
            for document in querySnapshot?.documents ?? [] {
                print("\(document.documentID) => \(document.data())")
                
                let data = document.data()
                let questionString = data["question"] as? String ?? ""
                let correntAnswer = data["correntAnswer"] as? Int ?? 0
                let answers = data["answers"] as? [String] ?? []
                let question = QuestionModel(answers: answers,
                                             correntAnswer: correntAnswer,
                                             question: questionString)
                questions.append(question)
            }
            self?.updateChapter(courseDocumentId: courseDocumentId,
                                chapterDocumentId: chapterDocumentId,
                                questions: questions)
        }
    }
    
    private func updateCourse(documentId: String, chapters: [ChapterModel]) {
        if let element = courses.enumerated().first(where: { $0.element.documentId == documentId }) {
            courses[element.offset].chapters = chapters
        }
    }
    
    private func updateChapter(courseDocumentId: String, chapterDocumentId: String, questions: [QuestionModel]) {
        if let courseElement = courses.enumerated().first(where: {
            $0.element.documentId == courseDocumentId
        }) {
            if let chapterElement = courses[courseElement.offset].chapters?.enumerated().first(where: {
                $0.element.documentId == chapterDocumentId
            }) {
                courses[courseElement.offset].chapters?[chapterElement.offset].questions = questions
            }
        }
    }
}
