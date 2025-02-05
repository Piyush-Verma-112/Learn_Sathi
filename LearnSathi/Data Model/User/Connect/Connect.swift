//
//  Connect.swift
//  LearnSathi
//
//  Created by Batch - 2 on 15/01/25.
//

import Foundation
import UIKit
struct Tutor {
    let id: Int
    let tutorName: String
    let tutorProfileImage: String
    let subject: String
    let subjectIcon: String
    
}

struct RescheduleOption {
    let title: String
    let description: String
}


struct ConnectHub {
    let tutors: [Tutor]
    let rescheduleOptions: [RescheduleOption]
}

let tutors: [Tutor] = [
    Tutor(id: 1, tutorName: "Kuldeep Yadav", tutorProfileImage: "profileImage", subject: "Mathematics", subjectIcon: "Maths"),
    Tutor(id: 2, tutorName: "Shivam Gupta", tutorProfileImage: "profileImage", subject: "Hindi", subjectIcon: "Maths"),
    Tutor(id: 3, tutorName: "Rohit Yadav", tutorProfileImage: "profileImage", subject: "Science", subjectIcon: "Maths"),
    Tutor(id: 4, tutorName: "Kuldeep Yadav", tutorProfileImage: "profileImage", subject: "Mathematics", subjectIcon: "Maths"),
    Tutor(id: 5, tutorName: "Shivam Gupta", tutorProfileImage: "profileImage", subject: "Hindi", subjectIcon: "Maths"),
    Tutor(id: 6, tutorName: "Rohit Yadav", tutorProfileImage: "profileImage", subject: "Science", subjectIcon: "Maths")
]

let subjects = ["English", "Hindi", "Mathematics", "Social Science"]
var lessonsMapping: [String: [String]] = [
    "English": chapterDetailsEnglish.map { $0.chapterName },
    "Hindi": chapterDetailsHindi.map { $0.chapterName },
    "Mathematics": chapterDetailsMaths.map { $0.chapterName },
    "Social Science": chapterDetailsSocialStudies.map { $0.chapterName }
]
struct Doubts {
    let image: String
    let subjectName: String
    let lessonName: String
    let status: String
    let date: String
    let question: String
    let solution: String
    let solutionImages: [UIImage]
}

var doubts: [Doubts] = [
    Doubts(image: "profileImage", subjectName: "Mathematics", lessonName: "Derivatives", status: "Resolved", date: "12/07/25", question: "f(x) = (2x-1)+g(x)?", solution: "In the image", solutionImages: [UIImage(named: "solutionImage") ?? UIImage()])
]
