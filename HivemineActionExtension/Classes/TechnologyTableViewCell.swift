//
//  TechnologyTableViewCell.swift
//  HiveMind
//
//  Created by Red Davis on 24/06/2015.
//  Copyright (c) 2015 Red Davis. All rights reserved.
//

import UIKit

import Haneke


public class TechnologyTableViewCell: UITableViewCell
{
    public var technology: Technology? {
        didSet
        {
            self.reloadData()
        }
    }
    
    // MARK: Initialization
    
    public required init(reuseIdentifier: String)
    {
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
    }
    
    public required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    // MARK: View setup
    
    public override func layoutSubviews()
    {
        super.layoutSubviews()
        
        if let imageView = self.imageView
        {
            var imageViewFrame = imageView.frame
            imageViewFrame.size = CGSize(width: 20.0, height: 20.0)
            imageViewFrame.origin.y = floor((self.contentView.frame.height - imageViewFrame.height) / 2.0)
            imageViewFrame.origin.x = 15.0
            imageView.frame = imageViewFrame
            
            if let textLabel = self.textLabel
            {
                var textLabelFrame = textLabel.frame
                textLabelFrame.origin.x = imageViewFrame.maxX + 15.0
                
                textLabel.frame = textLabelFrame
            }
        }
    }
    
    // MARK:
    
    private func reloadData()
    {
        self.textLabel?.text = self.technology?.label
        
        if let imageURL = technology?.faviconURL
        {
            let fetcher = NetworkFetcher<UIImage>(URL: imageURL)
            Shared.imageCache.fetch(fetcher: fetcher).onSuccess { image in
                self.imageView?.image = image
            }
        }
    }
}
