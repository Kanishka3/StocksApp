//
//  BottomStickyView.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 02/11/24.
//

import UIKit

class BottomStickyView: UIView {
    
    struct StickyViewModel {
        let collapsedViewModel: [CollapsedViewModel]
        let title: String, rightText: String
        let rightTextColor: UIColor?
    }
    
    struct CollapsedViewModel {
        var leftText, rightText: String
        var rightTextColor: UIColor?
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: GlobalConstants.regularFont)
        label.textColor = .darkGray
        return label
    }()
    
    private let rightLabel = UILabel()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: GlobalConstants.chevronDown))
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    private let mainContentView = UIView()
    
    private var isCollapsed = true {
        didSet {
            let rotationAngle: CGFloat = isCollapsed ? 0 : .pi
            let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
            UIView.animate(withDuration: 0.25, animations: {
                   self.chevronImageView.transform = rotationTransform
               })
        }
    }
    
    private let collapseView = CollpasedView()
    private var collapseViewHeight: NSLayoutConstraint?
    
    private let mainContentStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 8
        return hStack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        mainContentView.backgroundColor = .secondarySystemBackground
        mainContentView.layer.cornerRadius = GlobalConstants.cornerRadius
        mainContentView.layer.maskedCorners = .top
        
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.font = UIFont.systemFont(ofSize: 14)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleCollapse))
        self.addGestureRecognizer(tapGesture)
        
        addSubviews(mainContentView, collapseView)
        sendSubviewToBack(collapseView)
        mainContentView.addSubviews(mainContentStack)
        mainContentStack.addArrangedSubviews(titleLabel, chevronImageView, UIView(), rightLabel)
        
        mainContentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainContentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainContentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainContentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        mainContentStack.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: GlobalConstants.padding).isActive = true
        mainContentStack.trailingAnchor.constraint(equalTo: mainContentView.trailingAnchor, constant: -GlobalConstants.padding).isActive = true
        mainContentStack.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: GlobalConstants.padding).isActive = true
        mainContentStack.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        
        collapseView.bottomAnchor.constraint(equalTo: topAnchor).isActive = true
        collapseView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collapseView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collapseView.isHidden = true
        collapseViewHeight = collapseView.heightAnchor.constraint(equalToConstant: 200)
        collapseViewHeight?.isActive = true
    }

    
    @objc private func toggleCollapse() {
        isCollapsed.toggle()
      
        if isCollapsed {
            self.backgroundColor = .white
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self else { return }
                collapseView.isHidden = true
                self.collapseView.transform = CGAffineTransform(translationX: .zero,
                                                                y: CGFloat(collapseView.estimatedHeight))
                self.layoutIfNeeded()
              
            }
        } else {
            self.backgroundColor = collapseView.backgroundColor
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let self else { return }
                self.collapseView.isHidden = false
                self.collapseView.transform = CGAffineTransform(translationX: .zero, y: .zero)
            })
        }
    }

    func setData(viewModel: StickyViewModel) {
        titleLabel.text = viewModel.title
        rightLabel.text = viewModel.rightText
        if let rightColor = viewModel.rightTextColor {
            rightLabel.textColor = rightColor
        }
        collapseView.setData(items: viewModel.collapsedViewModel)
        collapseViewHeight?.constant = collapseView.estimatedHeight
        isCollapsed = false
        collapseView.transform = CGAffineTransform(translationX: .zero,
                                                   y: -CGFloat(collapseView.estimatedHeight))
            layoutIfNeeded()
    }
    
    fileprivate class CollpasedView: UIView {
        
        var verticalStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 10
            return stackView
        }()
        
        let dividerView: UIView = {
            let divider = UIView()
            divider.backgroundColor = .gray
            return divider
        }()
        
        init() {
            super.init(frame: .zero)
            createView()
        }
        
        private var items = [CollapsedViewModel]()

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            createView()
        }
        
        func createView() {
            layer.cornerRadius = GlobalConstants.cornerRadius
            layer.maskedCorners = .top
            backgroundColor = .secondarySystemBackground
            
            addSubviews(verticalStackView, dividerView)
            
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GlobalConstants.padding).isActive = true
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -GlobalConstants.padding).isActive = true
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -GlobalConstants.padding).isActive = true
            verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: GlobalConstants.padding).isActive = true
            
            dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GlobalConstants.padding).isActive = true
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -GlobalConstants.padding).isActive = true
        }
        
        func setData(items: [CollapsedViewModel]) {
            verticalStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
            for item in items {
                let label = LabelStackView()
                label.setData(leftText: .custom(text: item.leftText),
                              rightText: .custom(color: item.rightTextColor, text: item.rightText))
                verticalStackView.addArrangedSubview(label)
            }
            self.items = items
        }
        
        var estimatedHeight: CGFloat {
            guard items.count > 1 else { return LabelStackView.estimatedHeight }
            let count = CGFloat(items.count)
            return (count * LabelStackView.estimatedHeight) + ((count - 1) * 10) + 24
        }
    }
}


