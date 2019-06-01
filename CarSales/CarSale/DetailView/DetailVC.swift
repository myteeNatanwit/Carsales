//
//  DetailVC.swift
//  CarSale
//
//  Created by Admin on 29/5/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var topViewBtm: NSLayoutConstraint!
    @IBOutlet weak var carTitle: UILabel!
    @IBOutlet weak var Location: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var SaleStatus: UILabel!
    @IBOutlet weak var Comments: UITextView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var btmView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var theUrl: String = "";
    let spinner = LoadingOverlay();
    var photos:[String] = [];
    var carModel: String = "";
    
    static var previousPage: Int = 0; // detect index on scroll
    
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true;
        spinner.showOverlay(view: self.view);
        let width = UIScreen.main.bounds.width // device width
        topViewBtm.constant = ((width - 20) / 3 * 2) ; // image container size ratio
        getData();
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait); // lock to see clearly comments
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
    func getData() {
        NetworkModel.getRequest(theUrl: theUrl) { text in
            do {
                let jdata = try JSONDecoder().decode(thedetail.self, from: text.data(using: .utf8)!);
                let data = jdata.Result;
                self.photos = data[0].Overview.Photos;
                self.Location.text = data[0].Overview.Location;
                self.Price.text = data[0].Overview.Price;
                self.SaleStatus.text = data[0].SaleStatus;
                self.Comments.text = data[0].Comments;
                self.carTitle.numberOfLines = 0;
                self.carTitle.text = self.carModel;
                self.collectionView.reloadData()
                self.spinner.hideOverlayView();
                self.navigationController?.isNavigationBarHidden = false;
                print("number of photos", self.photos.count);
            }
            catch {
                print ("Handle error")
            }
        }
    }
}
