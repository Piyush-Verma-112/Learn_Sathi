//
//  Connect.swift
//  LearnSathi
//
//  Created by Batch - 2 on 15/01/25.
//

import Foundation
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
    Tutor(id: 6, tutorName: "Rohit Yadav", tutorProfileImage: "profileImage", subject: "Science", subjectIcon: "Maths"),
    Tutor(id: 1, tutorName: "Kuldeep Yadav", tutorProfileImage: "profileImage", subject: "Mathematics", subjectIcon: "Maths"),
    Tutor(id: 2, tutorName: "Shivam Gupta", tutorProfileImage: "profileImage", subject: "Hindi", subjectIcon: "Maths"),
    Tutor(id: 3, tutorName: "Rohit Yadav", tutorProfileImage: "profileImage", subject: "Science", subjectIcon: "Maths")
]

