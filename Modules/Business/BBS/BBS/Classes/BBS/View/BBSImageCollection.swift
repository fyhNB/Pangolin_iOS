//
//  BBSImageCollection.swift
//  BBS
//
//  Created by 方昱恒 on 2022/4/12.
//

import UIKit
import PGFoundation
import Util
import SnapKit

class BBSImageCollection: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    weak var controller: UIViewController?
    
    var images = [UIImage]() {
        didSet {
            self.imageCollection.reloadData()
            if images.count == 0 {
                self.imageCollection.snp.remakeConstraints { make in
                    make.edges.equalTo(self)
                    make.height.equalTo(0)
                }
            } else {
                self.imageCollection.snp.remakeConstraints { make in
                    make.edges.equalTo(self)
                    make.height.equalTo(BBSImageCollection.imageWidth)
                }
            }
        }
    }
    
    var imageUrls = [String]() {
        didSet {
            self.imageCollection.reloadData()
            if imageUrls.count == 0 {
                self.imageCollection.snp.remakeConstraints { make in
                    make.edges.equalTo(self)
                    make.height.equalTo(0)
                }
            } else {
                self.imageCollection.snp.remakeConstraints { make in
                    make.edges.equalTo(self)
                    make.height.equalTo(BBSImageCollection.imageWidth)
                }
            }
        }
    }
    
    static var horizontalPadding: CGFloat = 20
     
    static var imageWidth = (Screen.screenWidth - horizontalPadding * 2) / 4.0 - 3
    
    private lazy var imageCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        let imageWidth = BBSImageCollection.imageWidth
        flowLayout.itemSize = CGSize(width: imageWidth, height: imageWidth)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .clear
 
        collection.register(BBSImageCollectionCell.self, forCellWithReuseIdentifier: BBSImageCollectionCell.reuserID)
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageCollection)
        imageCollection.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BBSImageCollection {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if images.count == 0 {
            return imageUrls.count > 4 ? 4 : imageUrls.count
        }
        if imageUrls.count == 0 {
            return images.count > 4 ? 4 : images.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BBSImageCollectionCell.reuserID, for: indexPath) as? BBSImageCollectionCell
        
        if images.count == 0 {
            cell?.imageView.sd_setImage(with: URL(string: imageUrls[indexPath.row]))
        }
        if imageUrls.count == 0 {
            cell?.imageView.image = images[indexPath.row]
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let images = ((collectionView.visibleCells as? [BBSImageCollectionCell]) ?? []).reversed().map { $0.imageView.image ?? UIImage() }
        let largeImageController = LargeImageController(images: images, startAt: indexPath.item)
        
        controller?.present(largeImageController, animated: true)
    }
    
}
