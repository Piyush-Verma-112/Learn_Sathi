//
//  ConnectDataController.swift
//  LearnSathi
//
//  Created by Batch - 2 on 07/02/25.
//

import Foundation
import UIKit

class ConnectDataController {
    static let shared = ConnectDataController()
    
    var tutors: [Tutor] = []
    var doubts: [Doubts] = []
    var lessonsMapping: [String: [String]] = [:]
    
    private init() {
        loadInitialData()
    }
    
    private func loadInitialData() {
        tutors = [
            Tutor(id: 1, tutorName: "Praveen Shrivastav", tutorProfileImage: "profileImage", subject: "Mathematics", subjectIcon: "Maths"),
            Tutor(id: 2, tutorName: "Shivam Gupta", tutorProfileImage: "profileImage", subject: "Hindi", subjectIcon: "Maths"),
            Tutor(id: 3, tutorName: "Rohit Yadav", tutorProfileImage: "profileImage", subject: "Science", subjectIcon: "Maths")
            
        ]
        
        doubts = [
            Doubts(subjectName: "Mathematics", lessonName: "Derivatives", status: "Resolved", date: "12/07/25", question: "f(x) = (2x-1)+g(x)?", solution: "In the image", solutionImages: [
                UIImage(named: "solutionImage") ?? UIImage(),
                UIImage(named: "solutionImage") ?? UIImage(),
                UIImage(named: "solutionImage") ?? UIImage()
            ])
        ]
        
        lessonsMapping = [
            "English": chapterDetailsEnglish.map { $0.chapterName },
            "Hindi": chapterDetailsHindi.map { $0.chapterName },
            "Mathematics": chapterDetailsMaths.map { $0.chapterName },
            "Social Science": chapterDetailsSocialStudies.map { $0.chapterName }
        ]
    }
    
    func getTutors() -> [Tutor] {
        return tutors
    }
    
    func getDoubts() -> [Doubts] {
        return doubts
    }
    
    func addDoubt(_ doubt: Doubts) {
        doubts.append(doubt)
    }
    
    func deleteDoubt(at index: Int) {
        if index < doubts.count {
            doubts.remove(at: index)
        }
    }
}


