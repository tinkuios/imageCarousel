//
//  ListTableViewCell.swift
//  SwiftExamApp
//
//  Created by Tinku Sardar on 23/08/24.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookName : UILabel!
    @IBOutlet weak var bookImg : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    // MARK: - Data load - for API
    
    func dataLoad(position:NSInteger,data:[entriesData]){
        bookName.text = data[position].title ?? ""
        
        // bookImg?.imageFromServerURL(urlString: (APIUrl.HTTPS + (data[position].picture?.url ?? "")), PlaceHolderImage: UIImage.init(named: "placeholder")!)
        let urlString = (APIUrl.HTTPS + (data[position].picture?.url ?? ""))
        loadImage(from: urlString, into: bookImg!) ////We can use both method, this one and above too
        ///APIUrl.HTTPS is using because in the response "https:" is missing in url object
    }
}
// MARK: - Download Image with extension

extension  UIImageView {
    
    func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        
        if self.image == nil{
            self.image = PlaceHolderImage
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                debugPrint(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
