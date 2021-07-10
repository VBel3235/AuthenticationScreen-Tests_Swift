//
//  VBButton.swift
//  M11LoginPasswordProjectPlusTests
//
//  Created by Владислав Белов on 10.07.2021.
//

import UIKit

class VBButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private func configure(){
        layer.cornerRadius = 12
        backgroundColor = .systemOrange
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("Login", for: .normal)
    }
    
}
