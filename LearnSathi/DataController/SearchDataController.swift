//
//  SearchDataController.swift
//  LearnSathi
//
//  Created by Shahma Ansari on 09/02/25.
//

//
//  SearchDataController.swift
//  LearnSathi
//

import Foundation

class SearchDataController {
    
    private var searchResults: [TutorId] = []
    private var allSubjects = ["Mathematics", "Science", "History", "Geography", "English", "Computer Science", "Biology", "Physics", "Chemistry"]
    private var filteredSubjects: [String] = []

    static var shared = SearchDataController()
    
    private init() {
        loadDummyData()
    }
    
    func loadDummyData() {
        searchResults = [
            TutorId(id: UUID(), fullName: "Md Akhlak", gender: Gender.Male, profileImage: "profileImage", bio: "The best science and maths teacher in your nearby locality.", experience: "3yrs", charges: 5000, subjects: ["Science", "Maths"], Standard: [5, 6, 1, 2], gradInstitute: "Galgotias University", address: "Greater Noida, UP", ratings: 4.7),
            
            TutorId(id: UUID(), fullName: "Rohit Sharma", gender: Gender.Male, profileImage: "profileImage1", bio: "Passionate about making learning fun and effective.", experience: "5yrs", charges: 6000, subjects: ["English", "Social Science"], Standard: [3, 4, 5, 6], gradInstitute: "Delhi University", address: "New Delhi, DL", ratings: 4.8),
            
            TutorId(id: UUID(), fullName: "Anjali Verma", gender: Gender.Female, profileImage: "profileImage2", bio: "Dedicated tutor with a knack for simplifying complex topics.", experience: "4yrs", charges: 5500, subjects: ["Maths", "Physics"], Standard: [7, 8, 9, 10], gradInstitute: "IIT Kanpur", address: "Lucknow, UP", ratings: 4.6),
            
            TutorId(id: UUID(), fullName: "Suresh Patil", gender: Gender.Male, profileImage: "profileImage3", bio: "Expert in conceptual learning with hands-on experience.", experience: "6yrs", charges: 7000, subjects: ["Chemistry", "Biology"], Standard: [9, 10, 11, 12], gradInstitute: "Mumbai University", address: "Mumbai, MH", ratings: 4.9)
        ]
    }
    
    // MARK: - Data Access Methods
    
    func allSearchResults() -> [TutorId] {
        return searchResults
    }
    
    func getAllSubjects() -> [String] {
        return allSubjects
    }
    
    func getFilteredSubjects() -> [String] {
        return filteredSubjects
    }
    
    func getAllStandards() -> [Standard] {
        return standards
    }
    
    // MARK: - Data Manipulation Methods
    
    func addNewSubject(_ subject: String) {
        if !allSubjects.contains(subject) {
            allSubjects.append(subject)
        }
    }
    
    func filterSubjects(for query: String) {
        if query.isEmpty {
            filteredSubjects = []
        } else {
            filteredSubjects = allSubjects.filter { $0.lowercased().contains(query.lowercased()) }
        }
    }
    
    // MARK: - Search Methods
    
    func searchTutors(bySubject subject: String) -> [TutorId] {
        return searchResults.filter { $0.subjects.contains(subject) }
    }
    
    func searchTutors(byStandard standard: Int) -> [TutorId] {
        return searchResults.filter { $0.Standard.contains(standard) }
    }
    
    func searchTutors(byPriceRange min: Double, max: Double) -> [TutorId] {
        return searchResults.filter { $0.charges >= Int(min) && $0.charges <= Int(max) }
    }
}
