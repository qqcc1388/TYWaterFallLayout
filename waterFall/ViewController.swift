//
//  ViewController.swift
//  waterFall
//
//  Created by Tiny on 2017/5/22.
//  Copyright © 2017年 LOVEGO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   fileprivate lazy var collectionView: UICollectionView = {
        let layout = TYWaterFallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.dataSource = self
//        let itemW:CGFloat = (self.view.bounds.size.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing*(2.0))/3.0
//        let itemH:CGFloat = itemW * 0.8
//        layout.itemSize = CGSize(width: itemW, height: itemH)
        let collection:UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib. 
        view.addSubview(collectionView)
    }

}


extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(256))/255.0, green: CGFloat(arc4random_uniform(256))/255.0, blue: CGFloat(arc4random_uniform(256))/255.0, alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("选中item = \(indexPath.row)")
    }
}

extension ViewController : TYWaterFallLayoutDataSource{
    func numberOfcols(_ waterFall: TYWaterFallLayout) -> Int {
        return 3
    }
    
    func waterFall(_ waterFall: TYWaterFallLayout, item: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(150)) + CGFloat(100)
    }
}
