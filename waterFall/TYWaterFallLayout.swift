//
//  TYWaterFallLayout.swift
//  waterFall
//
//  Created by Tiny on 2017/5/22.
//  Copyright © 2017年 LOVEGO. All rights reserved.
//

import UIKit


@objc protocol TYWaterFallLayoutDataSource : class{
    
   func numberOfcols(_ waterFall:TYWaterFallLayout) ->Int
   @objc optional func waterFall(_ waterFall:TYWaterFallLayout,item:Int) -> CGFloat
    
}

class TYWaterFallLayout: UICollectionViewFlowLayout {

    weak var dataSource:TYWaterFallLayoutDataSource?
    
    lazy var attrs:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    fileprivate lazy var cols:Int = {
        return self.dataSource?.numberOfcols(self) ?? 2
    }()
    
    lazy var heights:[CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
    fileprivate var startIndex:Int = 0
    
}

// MARK: - 准备item atts 数据
extension TYWaterFallLayout{
    override func prepare() {
        super.prepare()
        
        //item个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        let itemW:CGFloat = (collectionView!.bounds.size.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing*CGFloat(cols - 1))/CGFloat(cols)
        
        //创建指定个数的atts
        for i in startIndex..<itemCount {
            //计算indexPath
            let indexPath = IndexPath(item: i, section: 0)
            //创建atts
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
           
            guard  let itemH:CGFloat = dataSource?.waterFall!(self, item: i) else {
                fatalError("请实现对应的数据源方法，返回cell高度")
            }
            
            let height = heights.min()!
            let index = heights.index(of: height)!
            
            let itemX = sectionInset.left + (itemW + minimumInteritemSpacing)*CGFloat(index)

            let itemY:CGFloat = height + minimumLineSpacing
            
            //设置attr的frame
            attr.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
            
            //保存heights
            heights[index] = height + minimumLineSpacing + itemH
            //保存frame
            attrs.append(attr)
        }
        //记录当前最大的count
        startIndex = itemCount
    }
}


// MARK: - 返回准备好的atts
extension TYWaterFallLayout{
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrs
    }
}

// MARK: - 返回contentsize
extension TYWaterFallLayout{
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: heights.max()! + sectionInset.bottom)
    }
}

