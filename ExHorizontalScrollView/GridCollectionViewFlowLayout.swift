//
//  GridCollectionViewFlowLayout.swift
//  ExHorizontalScrollView
//
//  Created by Jake.K on 2022/05/16.
//

import UIKit

class GridCollectionViewFlowLayout: UICollectionViewFlowLayout {
  var ratioHeightToWidth = 1.0
  var numberOfColumns = 1
  var cellSpacing = 0.0 {
    didSet {
      self.minimumLineSpacing = self.cellSpacing
      self.minimumInteritemSpacing = self.cellSpacing
    }
  }
  
  override init() {
    super.init()
    self.scrollDirection = .vertical
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
}
