//
//  DescriptionViewController.swift
//  Contacts
//
//  Created by v.ampilogov on 17/01/2019.
//

import UIKit

class DescriptionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProgressUpdating {
    
    weak var delegate: ProgressSynchronizerDelegate?
    
    private let descriptions: [DescriptionViewModel]
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    init(descriptions: [DescriptionViewModel]) {
        self.descriptions = descriptions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.pinToSuperview()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DescriptionCell.self, forCellWithReuseIdentifier: DescriptionCell.className)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.flowLayout?.minimumInteritemSpacing = 0
        collectionView.flowLayout?.minimumLineSpacing = 0
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return descriptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DescriptionCell.className, for: indexPath)
        
        if let cell = cell as? DescriptionCell {
            let description = descriptions[indexPath.row]
            cell.configure(with: description)
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.bounds.size
    }
    
    // MARK: - ProgressUpdating
    
    func update(_ progress: Double) {
        collectionView.contentOffset.y = CGFloat(progress) * view.frame.height
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let progress = scrollView.contentOffset.y / view.frame.height
        delegate?.didUpdate(updater: self, progress: Double(progress))
    }
}
