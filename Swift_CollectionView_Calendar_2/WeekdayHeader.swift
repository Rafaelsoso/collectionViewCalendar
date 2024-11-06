//
//  WeekdayHeader.swift
//  Swift_CollectionView_Calendar_2
//
//  Created by anh.nguyen3 on 6/11/24.
//
import UIKit

// Custom header for weekdays
class WeekdayHeader: UICollectionReusableView {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.frame = bounds
        label.textAlignment = .center
        label.backgroundColor = UIColor.darkGray
        label.textColor = .white
        addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
