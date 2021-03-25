//
//  SearchTableViewCell.swift
//  SearchResult
//
//  Created by Neeleshwari Mehra on 23/03/21.
//  Copyright © 2021 Hiteshi. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblStepName: UILabel!
    @IBOutlet var lblActivityName: UILabel!
    @IBOutlet var lblProgressPercentage: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var lblApt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblApt.layer.addBorder(edge: UIRectEdge.left, color: UIColor.lightGray.withAlphaComponent(0.5), thickness: 3)
        
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
