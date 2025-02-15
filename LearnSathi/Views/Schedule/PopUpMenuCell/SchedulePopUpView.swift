import UIKit
class SchedulePopUpView: UIView {
    
    private let tutorImageView = UIImageView()
    private let tutorLabel = UILabel()
    private let tutorNameLabel = UILabel()
    private let durationView = UIImageView()
    private let durationLabel = UILabel()
    
    private let subjectNameLabel = UILabel()
    private let subjectLogoImageView = UIImageView()
    
    private let tasksLabel = UILabel()
    private let topicNameLabel = UILabel()
    private let lessonLabel = UILabel()
    private let lessonNumberLabel = UILabel()
    
    private let topicsStackView = UIStackView()
    
    private let startTimeLabel = UILabel()
    private let startTimeValueLabel = UILabel()
    private let endTimeLabel = UILabel()
    private let endTimeValueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 10
        
        setupTutorSection()
        setupSubjectSection()
        setupTasksSection()
        setupTimeSection()
    }
    
    private func setupTutorSection() {
        // Tutor section
        let tutorStack = UIStackView()
        tutorStack.axis = .horizontal
        tutorStack.spacing = 8
        tutorStack.alignment = .center
        
        tutorImageView.image = UIImage(systemName: "person.circle.fill")
        tutorImageView.tintColor = .systemGray
        tutorImageView.contentMode = .scaleAspectFit
        tutorImageView.widthAnchor.constraint(equalToConstant: 23).isActive = true
        tutorImageView.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        tutorLabel.text = "Tutor"
        tutorLabel.textColor = .gray
        tutorLabel.font = .systemFont(ofSize: 17)
        
        tutorNameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        
        let durationStack = UIStackView()
        durationStack.axis = .horizontal
        durationStack.spacing = 5
        
        durationView.image = UIImage(systemName: "clock.fill")
        durationView.tintColor = .systemGray
        durationView.contentMode = .scaleAspectFit
        durationView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        durationLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        durationLabel.textColor = .black
        
        
        tutorStack.addArrangedSubview(tutorImageView)
        tutorStack.addArrangedSubview(tutorLabel)
        tutorStack.addArrangedSubview(tutorNameLabel)
        
        durationStack.addArrangedSubview(durationView)
        durationStack.addArrangedSubview(durationLabel)
        
        let topStack = UIStackView(arrangedSubviews: [tutorStack, durationStack])
        topStack.axis = .horizontal
        topStack.distribution = .equalSpacing
        topStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(topStack)
        
        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: topAnchor, constant: 48),
            topStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            topStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupSubjectSection() {
        // Subject section
        subjectNameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        subjectNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subjectLogoImageView.contentMode = .scaleAspectFit
        subjectLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subjectNameLabel)
        addSubview(subjectLogoImageView)
        
        NSLayoutConstraint.activate([
            subjectNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 110),
            subjectNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            subjectLogoImageView.centerYAnchor.constraint(equalTo: subjectNameLabel.centerYAnchor),
            subjectLogoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            subjectLogoImageView.widthAnchor.constraint(equalToConstant: 40),
            subjectLogoImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTasksSection() {
        // Tasks section
        tasksLabel.text = "Today's tasks"
        tasksLabel.font = .systemFont(ofSize: 18, weight: .medium)
        tasksLabel.textColor = .gray
        
        topicNameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        
        lessonLabel.text = "Lesson"
        lessonLabel.font = .systemFont(ofSize: 15)
        lessonLabel.textColor = .gray
        
        lessonNumberLabel.font = .systemFont(ofSize: 15, weight: .medium)
        
        let lessonStack = UIStackView(arrangedSubviews: [lessonLabel, lessonNumberLabel])
        lessonStack.axis = .horizontal
        lessonStack.spacing = 5
        
        let topicHeaderStack = UIStackView(arrangedSubviews: [topicNameLabel, lessonStack])
        topicHeaderStack.axis = .horizontal
        topicHeaderStack.distribution = .equalSpacing
        
        topicsStackView.axis = .vertical
        topicsStackView.spacing = 8
        
        let tasksStack = UIStackView(arrangedSubviews: [
            tasksLabel,
            topicHeaderStack,
            topicsStackView
        ])
        tasksStack.axis = .vertical
        tasksStack.spacing = 15
        tasksStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tasksStack)
        
        NSLayoutConstraint.activate([
            tasksStack.topAnchor.constraint(equalTo: subjectNameLabel.bottomAnchor, constant: 30),
            tasksStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tasksStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func setupTimeSection() {
        // Time section
        startTimeLabel.text = "Start Time"
        startTimeLabel.font = .systemFont(ofSize: 14)
        startTimeLabel.textColor = .gray
        
        startTimeValueLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        endTimeLabel.text = "End Time"
        endTimeLabel.font = .systemFont(ofSize: 14)
        endTimeLabel.textColor = .gray
        
        endTimeValueLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        let timeStack = UIStackView(arrangedSubviews: [
            startTimeLabel,
            startTimeValueLabel,
            endTimeLabel,
            endTimeValueLabel
        ])
        timeStack.axis = .horizontal
        timeStack.distribution = .equalSpacing
        timeStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(timeStack)
        
        NSLayoutConstraint.activate([
            timeStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            timeStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            timeStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func configure(with schedule: Schedule) {
        tutorNameLabel.text = schedule.tutorName
        durationLabel.text = schedule.duration
        
        subjectNameLabel.text = schedule.subjectName
        subjectLogoImageView.image = UIImage(named: schedule.subjectLogo)
        
        topicNameLabel.text = schedule.chapterName
        lessonNumberLabel.text = String(schedule.lessonNumber)
        
        // Clear existing topic views
        topicsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add topic bullet points
        for topic in schedule.topicDescription {
            let bulletPoint = UIImage(systemName: "circle.fill")
            let topicImageView = UIImageView(image: bulletPoint)
            topicImageView.tintColor = .black
            topicImageView.contentMode = .scaleAspectFit
            topicImageView.widthAnchor.constraint(equalToConstant: 5).isActive = true
            topicImageView.heightAnchor.constraint(equalToConstant: 5).isActive = true
            
            let topicLabel = UILabel()
            topicLabel.text = topic
            topicLabel.font = .systemFont(ofSize: 16)
            
            let topicStack = UIStackView(arrangedSubviews: [topicImageView, topicLabel])
            topicStack.axis = .horizontal
            topicStack.spacing = 10
            topicStack.alignment = .center
            
            topicsStackView.addArrangedSubview(topicStack)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        startTimeValueLabel.text = formatter.string(from: schedule.startTime)
        endTimeValueLabel.text = formatter.string(from: schedule.endTime)
    }
}
