//
//  ViewController.swift
//  CarSale
//
//  Created by Admin on 29/5/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // for size width and height
    var sizeW: CGFloat = 0.0;
    var sizeH: CGFloat = 0.0;
    
    let spinner = LoadingOverlay();
    let pickerData = ["ALL","ACT","NT","NSW","QLD","SA","TAS","VIC","WA"];
    var carTitle: String = "";
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        let titleView = TitleView(navigationController: navigationController!, title: "All States", items: pickerData);
        navigationItem.titleView = titleView;
        self.navigationController?.isNavigationBarHidden = true;
        spinner.showOverlay(view: self.view);
        getData();
        displayTraitCollection();
        
//Picker callback
        titleView?.action = { [weak self] index in
            print("select \(index)");
            let selected = self?.pickerData[index];
            if selected == "ALL" {
                Tfilter = Tdata;
            } else {
                Tfilter = Tdata.filter{$0.Location == selected};
            }
            self?.collectionView.reloadData();
            self?.collectionView.setContentOffset(CGPoint.zero, animated: true);
        }
    }
    
// MARK: - Layout
    //convert to strings for debug
    func sizeClassText(_ sizeClass: UIUserInterfaceSizeClass) -> String {
        switch sizeClass {
        case .compact:
            return "Compact"
        case .regular:
            return "Regular"
        default:
            return "Unspecified"
        }
    }
    
    func deviceText(_ deviceType: UIUserInterfaceIdiom) -> String {
        switch deviceType {
        case .phone:
            return "iPhone"
        case .pad:
            return "iPad"
        case .tv:
            return "Apple TV"
        default:
            return "Unspecified"
        }
    }
    
    //changes to the view based on the class sizes
    func displayTraitCollection() {
        
        print("Device:" + deviceText(traitCollection.userInterfaceIdiom));
        print("Height:" + sizeClassText(traitCollection.verticalSizeClass));
        print("Width:" + sizeClassText(traitCollection.horizontalSizeClass));
        
        let height = UIScreen.main.bounds.height - 20  // safe area;
        let width = UIScreen.main.bounds.width // device width
        sizeH = 350; // preset for ratio of Iphone
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        //compact horizontal size class -- iPhone landscape or vertical
        if traitCollection.horizontalSizeClass == .compact {
            sizeW = width / 2.2; // leave room for inset
            //sizeH = height / 3;
            
            if traitCollection.verticalSizeClass == .regular { // vertical iphone
                sizeW = width;
                if UIDevice.current.orientation.isLandscape { // ip+ is an exception
                    sizeW = height / 2.2;
                    print("iphone+ landscape");
                }
            }
            
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0); // margin: 0
            layout.minimumInteritemSpacing = 1 ;// gap between 2 items
            layout.itemSize = CGSize(width: sizeW, height: sizeH); // item size
            self.collectionView!.collectionViewLayout = layout; // set new layout
        } else { //Regular horizontal size class -- iPad, iPhone Plus landscape
                sizeW = width / 2.2;
                if traitCollection.userInterfaceIdiom == .pad { // ipad landscape
                    sizeW = width / 3.3;
                    print("ipad landscape");
                    layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                }
            if UIDevice.current.orientation.isLandscape {
                layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            } else { // ip+ is an exception
                sizeW = height;
                layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
                print("IP+ portrait - weird");
            }
          //  layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            layout.minimumInteritemSpacing = 0.5 // gap btween 2 items
            layout.itemSize = CGSize(width: sizeW, height: sizeH); // item size
            self.collectionView!.collectionViewLayout = layout // set new layout
        }
        updateViewConstraints()
    }
    // capture device rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator);
        if UIDevice.current.orientation.isLandscape {
            print("Landscape");
        } else {
            print("Portrait");
        }
        displayTraitCollection();
        collectionView.setContentOffset(CGPoint.zero, animated: true);
    }

// MARK: - Data
    func getData() {
        let theUrl = domain + DetailsUrl + param;
      
        NetworkModel.getRequest(theUrl: theUrl) { text in
            do {
                let jdata = try JSONDecoder().decode(thedata.self, from: text.data(using: .utf8)!);
                let data = jdata.Result;
                Tdata = data; // all states
                Tfilter = data;
                self.collectionView.reloadData();
                self.spinner.hideOverlayView();
                self.navigationController?.isNavigationBarHidden = false;
                print("no elements", Tdata.count);
            }
            catch {
                print ("Handle error")
            }
        }
    }

}

