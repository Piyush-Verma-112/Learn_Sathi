import Foundation

extension Notification.Name {
    static let tutorDataUpdated = Notification.Name("com.projectx.tutorDataUpdated")
}

class SearchDataController {
    private var searchResults: [TutorId] = []
    private var allSubjects: [String] = []
    private var filteredSubjects: [String] = []
    private var standards: [String] = []
    
    static var shared = SearchDataController()
    private let baseURL = "http://localhost:3000"
    
    private init() {
        loadDummyData()
    }
    
    func loadDummyData() {
        allSubjects = ["Mathematics", "Science", "History", "Geography", "English", "Computer Science", "Biology", "Physics", "Chemistry"]
        standards = ["Class 1", "Class 2", "Class 3", "Class 4", "Class 5", "Class 6", "Class 7", "Class 8"]

    }

    
    // MARK: - Network Methods
    
    func fetchTutors(completion: @escaping (Result<[TutorId], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/tutor/all") else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Invalid response", code: -1, userInfo: nil)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "No data received", code: -1, userInfo: nil)))
                }
                return
            }
            
            do {
                let tutors = try JSONDecoder().decode([TutorId].self, from: data)
                DispatchQueue.main.async {
                    self.searchResults = tutors // Update the searchResults property
                    print("Fetched tutors: \(tutors.count)") // Debug print
                    completion(.success(tutors))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Data Access Methods
    
    func allSearchResults() -> [TutorId] {
        return searchResults
    }
    
    func getAllSubjects() -> [String] {
        return Array(allSubjects).sorted()
    }
    
    func getFilteredSubjects() -> [String] {
        return filteredSubjects
    }
    
    func getAllStandards() -> [String] {
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
            filteredSubjects = getAllSubjects().filter { $0.lowercased().contains(query.lowercased()) }
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
