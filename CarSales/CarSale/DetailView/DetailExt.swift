//
//  DetailExt.swift
//  CarSale
//
//  Created by Admin on 29/5/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Foundation

extension DetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as! DetailCollectionViewCell;
        cell.imgView.downloadedFrom(url: photos[indexPath.row]);
        return cell;
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let pageWidth: CGFloat = scrollView.frame.width
        let fractionalPage: CGFloat = scrollView.contentOffset.x / pageWidth;
        let page = lround(Double(fractionalPage))
        if page != DetailVC.previousPage
        {
            //print(page) // page changed
        }
    }

}
