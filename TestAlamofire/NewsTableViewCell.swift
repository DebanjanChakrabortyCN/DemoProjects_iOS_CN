//
//  NewsTableViewCell.swift
//  TestAlamofire
//
//  Created by CN320 on 4/21/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    weak public var newsData : NewsData?
    
    var didUpdateConstraints : Bool!
    
    private lazy var newsDescriptionLabel : UILabel = {
        var newsLabel : UILabel = UILabel.init()
        newsLabel.backgroundColor = .green
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        newsLabel.numberOfLines = 0
        newsLabel.lineBreakMode = .byWordWrapping
        newsLabel.textColor = .black
        return newsLabel
    }()
    
    private lazy var newsTitleLabel : UILabel = {
        var newsLabel : UILabel = UILabel.init()
        newsLabel.backgroundColor = .yellow
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        newsLabel.numberOfLines = 0
        newsLabel.lineBreakMode = .byWordWrapping
        newsLabel.textColor = .black
        return newsLabel
    }()
    
    
    private lazy var newsAuthorLabel : UILabel = {
        var newsLabel : UILabel = UILabel.init()
        newsLabel.backgroundColor = .brown
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        newsLabel.numberOfLines = 0
        newsLabel.lineBreakMode = .byWordWrapping
        newsLabel.textAlignment = .right
        newsLabel.textColor = .black
        return newsLabel
    }()
    
    private var newsImageView : UIImageView = {
        var newsImageView : UIImageView = UIImageView.init()
        newsImageView.backgroundColor = .purple
        newsImageView.contentMode = .scaleAspectFit
        return newsImageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.contentView.removeConstraints(self.contentView.constraints)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(newsTitleLabel)
        
        self.contentView.addSubview(newsDescriptionLabel)
        
        self.contentView.addSubview(newsAuthorLabel)
        
        //self.contentView.addSubview(newsImageView)
    
        self.contentView.backgroundColor = .white
        
        self.contentView.clipsToBounds = true
        
        
        self.didUpdateConstraints = false
        
        self.setNeedsUpdateConstraints()
    }
    
    func updateUI()-> Void{
        
        guard newsData != nil else { return }
    
        self.newsTitleLabel.text = newsData?.newsTitle
        
        self.newsDescriptionLabel.text = newsData?.newsDescription
        
        let newsAuthor = newsData?.newsAuthor
        
        if((newsAuthor?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count) != nil)
        {
            self.newsAuthorLabel.text = String("By : " + newsAuthor!)
        }
        
        self.didUpdateConstraints = false
        self.contentView.updateConstraintsIfNeeded()
    }

    override func updateConstraints() {
        
        if !self.didUpdateConstraints
        {
            let viewBindingsDict = ["newsTitleLabel" : newsTitleLabel,
                                    "newsAuthorLabel" : newsAuthorLabel,
                                    "newsDescriptionLabel" : newsDescriptionLabel,
                                    "newsImageView" : newsImageView] as [String : Any]
            
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[newsTitleLabel]-10-[newsAuthorLabel]-10-[newsDescriptionLabel]-5-|", options: NSLayoutFormatOptions.alignAllRight, metrics: nil, views: viewBindingsDict as [String : Any]))
            
            
            /*self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"V:|-10-[newsImageView]-(>=10)-|" , options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: viewBindingsDict as [String : Any]))
            
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|-10-[newsImageView]" , options: NSLayoutFormatOptions.alignAllLeft, metrics: nil, views: viewBindingsDict as [String : Any]))*/
        
            
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=20)-[newsTitleLabel]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: viewBindingsDict as [String : Any]))
            
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=0)-[newsAuthorLabel]-(<=20)-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: viewBindingsDict as [String : Any]))
            
            self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=20)-[newsDescriptionLabel]-20-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: viewBindingsDict as [String : Any]))
            
            self.didUpdateConstraints = true
        }
        
        
        super.updateConstraints()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
