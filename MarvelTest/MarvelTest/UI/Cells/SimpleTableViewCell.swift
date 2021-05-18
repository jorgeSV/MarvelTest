//
//  SimpleTableViewCell.swift
//  MarvelTest
//
//  Created by jorgeSV on 14/5/21.
//

import UIKit
import AlamofireImage

class SimpleTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.myImageView?.layer.cornerRadius = 32
        self.myImageView?.layer.masksToBounds = true
    }
    
    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    func setImageView(path:String?, ext:String?, andTitle title:String?, andDescription desc:String?) {
        
        if let path = path, let ext = ext {
            self.myImageView.af.setImage(withURL: URL.init(string: path + Constants.API_THUMB_TYPE + ext)!)
        }
        
        self.titleLabel.text = title
        self.descriptionLabel.text = desc
    }
}
