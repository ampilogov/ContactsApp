//
//  DescriptionCell.swift
//  Contacts
//
//  Created by v.ampilogov on 21/01/2019.
//

import UIKit

private struct Const {
    static let titleFont = UIFont.boldSystemFont(ofSize: 19)
    static let subtitleFont = UIFont.systemFont(ofSize: 14.0)
    static let aboutMeFont = UIFont.boldSystemFont(ofSize: 15)
    static let descriptionFont = UIFont.systemFont(ofSize: 14)
}

class DescriptionCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let aboutTitleLabel = UILabel()
    private let descriptionTextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        setupTitle()
        setupSubtitle()
        setupAboutMeText()
        setupDescription()
    }
    
    private func setupTitle() {
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        titleLabel.pin(leading: 0, top: 0, trailing: 0)
    }
    
    private func setupSubtitle() {
        subtitleLabel.font = Const.subtitleFont
        subtitleLabel.textColor = .gray
        subtitleLabel.textAlignment = .center
        contentView.addSubview(subtitleLabel)
        subtitleLabel.pin(height: 30)
        subtitleLabel.pin(leading: contentView.leadingAnchor,
                          top: titleLabel.bottomAnchor,
                          trailing: contentView.trailingAnchor)
    }
    
    private func setupAboutMeText() {
        aboutTitleLabel.font = Const.aboutMeFont
        aboutTitleLabel.text = "About me"
        contentView.addSubview(aboutTitleLabel)
        aboutTitleLabel.enableAutolayoutIfNeeded()
        aboutTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        aboutTitleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30).isActive = true
    }
    
    private func setupDescription() {
        descriptionTextView.isEditable = false
        descriptionTextView.font = Const.descriptionFont
        descriptionTextView.textColor = .gray
        descriptionTextView.textContainerInset = .zero
        contentView.addSubview(descriptionTextView)
        descriptionTextView.enableAutolayoutIfNeeded()
        descriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: aboutTitleLabel.bottomAnchor, constant: 4).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    
    func configure(with model: DescriptionViewModel) {
        let title = NSMutableAttributedString(string: model.firstName)
        title.addAttributes([.font: Const.titleFont],
                            range: NSRange(location: 0, length: model.firstName.count))
        title.append(NSAttributedString(string: " " + model.lastName))
        
        titleLabel.attributedText = title
        subtitleLabel.text = model.subtitle
        descriptionTextView.text = model.text
        descriptionTextView.contentOffset = .zero
    }
}
