//
//  ViewController.swift
//  ExHorizontalScrollView
//
//  Created by Jake.K on 2022/05/16.
//

import UIKit

class ViewController: UIViewController {
  private let gridFlowLayout: GridCollectionViewFlowLayout = {
    let layout = GridCollectionViewFlowLayout()
    layout.cellSpacing = 8
    layout.numberOfColumns = 2
    return layout
  }()
  
  private var dataSource = getSampleImages()
  
  private lazy var collectionView: UICollectionView = {
    let view = UICollectionView(frame: .zero, collectionViewLayout: self.gridFlowLayout)
    view.isScrollEnabled = true
    view.showsHorizontalScrollIndicator = false
    view.showsVerticalScrollIndicator = true
//    view.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
    view.contentInset = .zero
    view.backgroundColor = .clear
    view.clipsToBounds = true
    view.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.collectionView)

    NSLayoutConstraint.activate([
      self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
      self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
    ])
    
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    self.dataSource.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.id, for: indexPath) as! MyCell
    cell.prepare(image: self.dataSource[indexPath.item])
    return cell
  }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard
      let flowLayout = collectionViewLayout as? GridCollectionViewFlowLayout,
      flowLayout.numberOfColumns > 0
    else { fatalError() }
    
    let widthOfCells = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
    let widthOfSpacing = CGFloat(flowLayout.numberOfColumns - 1) * flowLayout.cellSpacing
    let width = (widthOfCells - widthOfSpacing) / CGFloat(flowLayout.numberOfColumns)

    return CGSize(width: width, height: width * flowLayout.ratioHeightToWidth)
  }
}

func getSampleImages() -> [UIImage?] {
  (1...100).map { _ in return UIImage(named: "dog") }
}
