//
//  TableViewCell.swift
//  assignment
//
//  Created by Anıl on 13.12.2018.
//  Copyright © 2018 Anıl. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemUrl: UILabel!
    @IBOutlet weak var itemImage: FetchImageView!
    
    var item: Item? {
        didSet {
            // setup UI elements from class properties
            itemTitle.text = item?.title
            itemUrl.text = item?.url
            if let ImageUrl = item?.url {
                itemImage.loadImage(urlString: ImageUrl)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
