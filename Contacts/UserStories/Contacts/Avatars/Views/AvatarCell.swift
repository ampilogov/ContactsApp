//
//  AvatarCell.swift
//  Contacts
//
//  Created by v.ampilogov on 17/01/2019.
//

import UIKit

private struct Const {
    static let avatarSize = CGSize(width: 65.0, height: 65.0)
    static let highlightSize = CGSize(width: 72.0, height: 72.0)
    static let highlightColor = UIColor(hex: 0xc6e0f4)
}

class AvatarCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let highlightView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        highlightView.alpha = 0
        highlightView.backgroundColor = Const.highlightColor
        highlightView.layer.cornerRadius = Const.highlightSize.width / 2
        contentView.addSubview(highlightView)
        highlightView.pinToSuperviewCenter()
        highlightView.pin(width: Const.highlightSize.width, height: Const.highlightSize.height)
        
        contentView.addSubview(imageView)
        imageView.pinToSuperviewCenter()
        imageView.pin(width: Const.avatarSize.width, height: Const.avatarSize.height)
    }
    
    func configure(with model: AvatarViewModel) {
        imageView.image = UIImage(named: model.imageName)
    }
    
    func updateHighlight(delta: CGFloat) {
        highlightView.alpha = delta
    }
}
