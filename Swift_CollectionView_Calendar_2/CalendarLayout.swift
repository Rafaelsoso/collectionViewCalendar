import UIKit

// Custom layout for the class schedule
class CalendarLayout: UICollectionViewLayout {
    private var cache = [UICollectionViewLayoutAttributes]()

    private let numberOfDays = ViewController.daysOfWeek.count
    private let numberOfTimeSlots = ViewController.timeSlots.count

    private let cellHeight: CGFloat = 60
    private let cellWidth: CGFloat = UIScreen.main.bounds.width / CGFloat(ViewController.daysOfWeek.count + 1) // + width for timeslot header

    override func prepare() {
        guard cache.isEmpty else { return }

        // Create layout attributes for weekday headers
        for day in 0..<numberOfDays {
            let indexPath = IndexPath(item: day, section: 0)
            let frame = CGRect(
                x: CGFloat(day) * cellWidth + cellWidth,
                y: 0,
                width: cellWidth,
                height: cellHeight
            )
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: indexPath)
            attributes.frame = frame
            cache.append(attributes)
        }
        
        // Create layout attributes for hours headers (left)
        for hour in 0..<numberOfTimeSlots {
            let indexPath = IndexPath(item: hour, section: 1)
            let frame = CGRect(
                x: 0,
                y: CGFloat(hour) * cellHeight + cellHeight,
                width: cellWidth,
                height: cellHeight
            )
            let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: "TimeSlotHeaderView", with: indexPath)
            attributes.frame = frame
            cache.append(attributes)
        }

        // Create layout attributes for each cell
        for timeSlot in 0..<numberOfTimeSlots {
            for day in 0..<numberOfDays {
                let indexPath = IndexPath(item: day + timeSlot * numberOfDays, section: 2) // Cells are in section 2
                let frame = CGRect(
                    x: CGFloat(day) * cellWidth + cellWidth,
                    y: CGFloat(timeSlot) * cellHeight + cellHeight, // Offset for header
                    width: cellWidth,
                    height: cellHeight
                )
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = frame
                cache.append(attributes)
            }
        }
    }

    override var collectionViewContentSize: CGSize {
         let totalWidth = self.collectionView?.bounds.width ?? 0
         let totalHeight = CGFloat(numberOfTimeSlots) * cellHeight + cellHeight
         return CGSize(width: totalWidth, height: totalHeight)
     }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }

    // TODO: use if want to adjust item attribute (layout, shaddow, color,...)
//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        return cache[indexPath.item + numberOfDays + numberOfTimeSlots] // Adjust for cells
//    }
//
//    override func layoutAttributesForSupplementaryView(ofKind kind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        if kind == UICollectionView.elementKindSectionHeader {
//            return cache[indexPath.item]
//        } else {
//            return cache[indexPath.item + numberOfDays] // Use the correct index for headers
//        }
//    }
}
