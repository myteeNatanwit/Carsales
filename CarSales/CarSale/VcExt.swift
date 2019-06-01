//
//  VcExt.swift
//  CarSale
//
//  Created by Admin on 29/5/19.
//  Copyright © 2019 Admin. All rights reserved.
//
import UIKit
import Foundation
 // MARK: - CollectionView
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Tfilter.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! CollectionViewCell;
        cell.imgView.downloadedFrom(url: Tfilter[indexPath.row].MainPhoto);

        cell.carModel.numberOfLines = 0;
        cell.carModel.text = Tfilter[indexPath.row].Title;
        let frame = cell.imgView.frame;
        let h = frame.width / 3 * 2;
        cell.imgView.frame = CGRect(x: 0, y: 0, width: frame.width, height: h);
      
        cell.price.text = Tfilter[indexPath.row].Price;
        cell.location.text = Tfilter[indexPath.row].Location;
        
        return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DetailsUrl = Tfilter[indexPath.row].DetailsUrl;
        carTitle = Tfilter[indexPath.row].Title;
        print(DetailsUrl);
        switchViewControllers(boardName: "Main", Id: "DetailVC");
    }
    
    func switchViewControllers(boardName: String, Id: String) {
        let storyboard = UIStoryboard.init(name: boardName, bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: Id) as! DetailVC;
        nav.theUrl = domain + DetailsUrl + param; // url
        nav.carModel = carTitle; // car title
        navigationController?.pushViewController(nav, animated: true)
    }
}

