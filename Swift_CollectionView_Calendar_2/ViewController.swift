import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

    // MARK: - Outlets
    var collectionView: UICollectionView!

    // MARK: - Private
    private let events: [Event] = [
        Event(day: 0, startTime: "09:00", endTime: "10:30", title: "Math 101"), // Monday
        Event(day: 1, startTime: "10:00", endTime: "12:00", title: "Biology 201"), // Tuesday
        Event(day: 2, startTime: "13:00", endTime: "14:30", title: "Chemistry 301"), // Wednesday
        Event(day: 3, startTime: "11:00", endTime: "12:30", title: "Physics 401"), // Thursday
        Event(day: 4, startTime: "15:00", endTime: "16:30", title: "History 101") // Friday
    ]

    // horizontal
    static let daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    // vertical
    static let timeSlots = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = CalendarLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self

        // Register classes with the collection view
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "calendarCell")
        collectionView.register(WeekdayHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "weekdayHeader")
        collectionView.register(WeekdayHeader.self, forSupplementaryViewOfKind: "TimeSlotHeaderView", withReuseIdentifier: "TimeSlotHeaderView")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellIdentifier")
        view.addSubview(collectionView)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3 // One for headers(day), one for headers(hour) , one for cells
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return ViewController.daysOfWeek.count // Number of headers (days)
        } else if section == 1 {
            return ViewController.timeSlots.count // Number of headers (hours)
        } else {
            return ViewController.daysOfWeek.count  * ViewController.timeSlots.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Handle only cells in section 1
        if indexPath.section == 2 {
            // Class cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calendarCell", for: indexPath) as! CalendarCell
            
            // Clear previous title
            cell.titleLabel.text = ""

            // Check if there are events in this cell's time slot
            let dayIndex = indexPath.item % (ViewController.daysOfWeek.count)
            let timeSlotIndex = indexPath.item / (ViewController.timeSlots.count)

            // Calculate time range for this time slot
            let startTime = String(format: "%02d:00", timeSlotIndex + 8) // Start at 8:00 AM
            let endTime = String(format: "%02d:00", timeSlotIndex + 9) // Each slot is 1 hour
            
            // Find event in this time slot
            if let event = events.first(where: { $0.day == dayIndex && $0.startTime <= endTime && $0.endTime > startTime }) {
                cell.titleLabel.text = event.title // Set the event title
            }
            return cell
        } else {
            // Return an empty cell or handle as needed
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellIdentifier", for: indexPath)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "weekdayHeader", for: indexPath) as! WeekdayHeader
            header.label.text = ViewController.daysOfWeek[indexPath.item]
            return header
        } else if  kind == "TimeSlotHeaderView" {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TimeSlotHeaderView", for: indexPath) as! WeekdayHeader
            header.label.text = ViewController.timeSlots[indexPath.item]
            return header
        }
        return UICollectionReusableView() // Fallback
    }
}
