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
            Tutor(id: UUID(), tutorName: "Praveen Shrivastav", tutorProfileImage: "profileImage", subject: ["Mathematics"], subjectIcon: "Maths"),
            Tutor(id: UUID(), tutorName: "Shivam Gupta", tutorProfileImage: "profileImage", subject: ["Mathematics"], subjectIcon: "Maths"),
            Tutor(id: UUID(), tutorName: "Rohit Yadav", tutorProfileImage: "profileImage", subject: ["Science"], subjectIcon: "science")
            
        ]
        
        doubts = [
            Doubts(subjectName: "Mathematics", lessonName: "Derivatives", status: "Resolved", date: "13 Jan 25", question: "f(x) = (2x-1)+g(x)?", solution: "In the image", solutionImages: [
                UIImage(named: "solutionImage") ?? UIImage(),
                UIImage(named: "solutionImage") ?? UIImage(),
                UIImage(named: "solutionImage") ?? UIImage()
            ])
        ]
        
        lessonsMapping = ProgressDataController.shared.getAllLessonsMapping()
    }
    
    func getTutors() -> [Tutor] {
        return tutors
    }
    
    func getDoubts() -> [Doubts] {
        return doubts
    }
    
    func addDoubt(_ doubt: Doubts) {
        doubts.insert(doubt,at: 0)
    }
    
}


