//
//  DocTableCell.swift
//  RefferingPhysicians
//
//  Created by Mike Gerdes on 2/2/15.
//  Copyright (c) 2015 Virginia Mason Medical Center. All rights reserved.
//
import UIKit

class DocTableCell: UITableViewCell {
    
    
    @IBOutlet weak var docName: UILabel!
    @IBOutlet weak var medSvc: UILabel!
    @IBOutlet weak var docImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
