//
//  RepoCell.swift
//  SampleMVP
//
//  Created by 三浦　登哉 on 2021/04/18.
//

import UIKit

final class RepoCell: UITableViewCell {
    
    @IBOutlet private weak var fullNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(repositoly: Repository) {
        fullNameLabel.text = repositoly.fullName
    }
}
