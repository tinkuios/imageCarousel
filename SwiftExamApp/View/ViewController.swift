//
//  ViewController.swift
//  SwiftExamApp
//
//  Created by Tinku Sardar on 23/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var CarouselTable : UICollectionView!
    @IBOutlet weak var listlTable : UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var pageControl: UIPageControl!
    var doneToolbar = UIToolbar()
    
    var imgArr = ["abc","ab","abcd"]
    var searchActive : Bool = false
    private var items : [entriesData]?
    private var filteredItems: [entriesData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerLayout()
        donBtn()
        
        // MARK: - Pagecontrol - using for page identify
        self.pageControl.numberOfPages = self.imgArr.count
        self.pageControl.currentPage = 0
        CarouselTable.reloadData()
        
        // MARK: - Fetch API Call
        let apiRequest = APIRequest()
        apiRequest.requestAPIInfo { (apiResult) in
            //debugPrint (apiResult)
            DispatchQueue.main.async {
                self.items = (SwiftModelObj.listData?.entries)!
                self.filteredItems = self.items!
                self.listlTable.reloadData()
            }
        }
    }
    
    // MARK: - Flowlsyout used for banner carousel
    
    func bannerLayout(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height:  240)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        CarouselTable!.collectionViewLayout = layout
    }
    
    // MARK: - Done button - using UIToolbar
    
    func donBtn(){
        doneToolbar.barStyle = UIBarStyle.default
        doneToolbar.isTranslucent = true
        doneToolbar.tintColor = .gray
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(self.donePressedAction))
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil)
        doneToolbar.setItems([spaceButton, doneButton], animated: false)
        doneToolbar.isUserInteractionEnabled = true
        doneToolbar.sizeToFit()
        self.searchBar.inputAccessoryView = doneToolbar
        
    }
    @objc func donePressedAction() {
        self.view.endEditing(true)
        designMethod(isCarousel: false)
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filteredItems = items!
        listlTable.reloadData()
    }
    
    // MARK: - Animation- used for colapsing
    
    func designMethod(isCarousel:Bool){
        UIView.animate(withDuration: 0.1,
                       delay: 0.1,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: { () -> Void in
            self.CarouselTable.isHidden = isCarousel
            self.pageControl.isHidden = isCarousel
        }, completion: { (finished) -> Void in
            
        })
        
    }
}


// MARK: - CollectionView for Banner

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as? CarouselCollectionViewCell else {
            fatalError("Unable to dequeue PersonCell.")
        }
        cell.img.image = UIImage(named: imgArr[indexPath.row])
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 220);
    }
}

// MARK: - Tableview for List

extension ViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell")as? ListTableViewCell else {
            fatalError("Unable to dequeue PersonCell.")
        }
        cell.dataLoad(position: indexPath.row, data: filteredItems)
        return cell
    }
}

// MARK: - Search list Method

extension ViewController : UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        designMethod(isCarousel: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.searchBar.showsCancelButton = false
        filteredItems = items!
        listlTable.reloadData()
        designMethod(isCarousel: false)
    }
    
    // MARK: - Search filter
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = !searchText.isEmpty
        
        if searchText.isEmpty {
            filteredItems = items!
            
        } else {
            
            filteredItems = items!.filter { entry in
                guard let title = entry.title else { return false }
                return title.lowercased().contains(searchText.lowercased())
            }
            
        }
        listlTable.reloadData()
    }
    
}

