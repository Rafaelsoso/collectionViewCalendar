import UIKit

// Custom cell for the schedule
class CalendarCell: UICollectionViewCell {
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.frame = contentView.bounds
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3) // Red background for events
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
