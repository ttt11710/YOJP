//
//  SearchCollectionReusableView.swift
//  YOJP
//
//  Created by PayBay on 15/12/21.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class SearchCollectionReusableView: UICollectionReusableView,UISearchBarDelegate {

    @IBOutlet weak var search: UISearchBar!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.search.delegate = self
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.search.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.search.resignFirstResponder()
    }

}
