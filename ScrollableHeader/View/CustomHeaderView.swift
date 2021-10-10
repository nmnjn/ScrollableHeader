//
//  CustomHeaderView.swift
//  ScrollableHeader
//
//  Created by Naman Jain on 10/10/21.
//

import UIKit

class CustomHeaderView: UIView {

    var animator: UIViewPropertyAnimator!
    
    var fractionComplete: CGFloat?{
        didSet{
            self.animator.fractionComplete = fractionComplete ?? 0
        }
    }
    
    
    private var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.backgroundColor = .systemPink
        return view
    }()
    
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Custom Header"
        label.font = .boldSystemFont(ofSize: 32)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        headerView.addSubview(titleLabel)
        titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -16).isActive = true
        
        self.setupAnimator()
        
    }
    
    private func setupAnimator(){
        
        self.animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut, animations: { [weak self] in
            guard let self = self else { return }
            self.titleLabel.alpha = 0
        })
        
        self.animator.pausesOnCompletion = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
