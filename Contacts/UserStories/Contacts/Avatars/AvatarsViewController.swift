//
//  AvatarsViewController.swift
//  Contacts
//
//  Created by v.ampilogov on 17/01/2019.
//

import UIKit
import QuartzCore

private struct Const {
    static let sliderVelocityCoefficient: CGFloat = 100
    static let minPercentageToSnapPage: CGFloat = 0.2
    static let itemSize = CGSize(width: 80, height: 80)
}

class AvatarsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProgressUpdating {
    
    weak var delegate: ProgressSynchronizerDelegate?
    
    private let avatars: [AvatarViewModel]
    private var currentPage: CGFloat = 0
    private var startingScrollingOffset = CGPoint.zero
    private lazy var offset = view.frame.width / 2 - Const.itemSize.width / 2

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init(avatars: [AvatarViewModel]) {
        self.avatars = avatars
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.contentInset = UIEdgeInsets(top: 0, left: offset, bottom: 0, right: offset)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateAvatarsHighlight()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.pinToSuperview()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: AvatarCell.className)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.flowLayout?.scrollDirection = .horizontal
        collectionView.flowLayout?.minimumInteritemSpacing = 0
        collectionView.flowLayout?.minimumLineSpacing = 0;
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCell.className, for: indexPath)
        
        if let cell = cell as? AvatarCell {
            let avatar = avatars[indexPath.row]
            cell.configure(with: avatar)
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Const.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let centerIndexPath = collectionView.centerIndexPath,
            indexPath.row != centerIndexPath.row else { return }
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // MARK: - ProgressUpdating
    
    func update(_ progress: Double) {
        collectionView.contentOffset.x = CGFloat(progress) * Const.itemSize.width - offset
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startingScrollingOffset = scrollView.contentOffset
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Calculate target page
        let cellWidth = Const.itemSize.width
        let offset = scrollView.contentOffset.x + scrollView.contentInset.left + velocity.x * Const.sliderVelocityCoefficient
        let targetPage = offset / cellWidth
        let snapDelta = offset > startingScrollingOffset.x ? (1 - Const.minPercentageToSnapPage) : Const.minPercentageToSnapPage
        
        // Base on snapDelta, choose targetPage or next of targetPage
        if floor(targetPage + snapDelta) == floor(targetPage) {
            currentPage = floor(targetPage)
        } else {
            currentPage = floor(targetPage + 1)
        }
        
        // Calculate targetContentOffset
        let targetX = cellWidth * currentPage
        targetContentOffset.pointee = CGPoint(x: targetX - collectionView.contentInset.left, y: targetContentOffset.pointee.y)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = (scrollView.contentOffset.x + offset) / Const.itemSize.width
        delegate?.didUpdate(updater: self, progress: Double(progress))
        updateAvatarsHighlight()
    }
    
    private func updateAvatarsHighlight() {
        
        guard let cell = collectionView.centerCell as? AvatarCell else { return }
        
        // Clear previous selection
        collectionView.visibleCells.compactMap({ $0 as? AvatarCell }).forEach { $0.updateHighlight(delta: 0) }
        
        // Calculate cell's delta position in central area
        let cellCenter = cell.contentView.convert(cell.contentView.center, to: self.view).x
        let viewCenter = view.frame.width / 2
        let offset = Const.itemSize.width / 2
        var delta = CGFloat(0)
        if cellCenter > viewCenter - offset && cellCenter < viewCenter + offset {
            delta = 1 - abs(cellCenter - viewCenter) / offset
        }
        
        cell.updateHighlight(delta: delta)
    }
}
