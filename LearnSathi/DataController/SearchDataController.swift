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
        fetchTutors()
    }
    
    func loadDummyData() {
        allSubjects = ["Mathematics", "Science", "History", "Geography", "English", "Computer Science", "Biology", "Physics", "Chemistry"]
        standards = ["Class 1", "Class 2", "Class 3", "Class 4", "Class 5", "Class 6", "Class 7", "Class 8"]

    }

    
    // MARK: - Network Methods
    
    func fetchTutors() {
        print("🔍 Starting to fetch tutors...")
        guard let url = URL(string: "\(baseURL)/tutor/all") else {
            print("❌ Invalid URL: \(baseURL)/tutor/all")
            return
        }
        
        print("📡 Making network request to: \(url)")
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                print("❌ Self was deallocated")
                return
            }
            
            if let error = error {
                print("❌ Network error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("❌ Invalid response status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)")
                return
            }
            
            guard let data = data else {
                print("❌ No data received")
                return
            }
            
            print("📦 Received data of size: \(data.count) bytes")
            
            do {
                let tutors = try JSONDecoder().decode([TutorId].self, from: data)
                print("✅ Successfully decoded \(tutors.count) tutors")
                
                if let firstTutor = tutors.first {
                    print("📝 Sample tutor data: \(firstTutor.fullName), Subjects: \(firstTutor.subjects)")
                }
                
                DispatchQueue.main.async {
                    self.searchResults = tutors
                    
                    print("📊 Processed data:")
                    print("- Total tutors: \(self.searchResults.count)")
                    print("- Unique subjects: \(self.allSubjects.count)")
                    print("- Unique standards: \(self.standards.count)")
                    
                    NotificationCenter.default.post(name: .tutorDataUpdated, object: nil)
                    print("✉️ Posted tutorDataUpdated notification")
                }
            } catch {
                print("❌ Decoding error: \(error)")
                if let dataString = String(data: data, encoding: .utf8) {
                    print("📄 Received data string: \(dataString)")
                }
            }
        }
        task.resume()
        print("🚀 Network request started")
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
