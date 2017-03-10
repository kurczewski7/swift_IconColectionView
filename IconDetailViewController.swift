//
//  IconDetailViewController.swift
//  CollectionViewDemo
//
//  Created by Slawek Kurczewski on 10.03.2017.
//  Copyright © 2017 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class IconDetailViewController: UIViewController {
    
    var icon: Icon?
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.image=UIImage(named: icon?.name  ?? "")
        }
    }
    
    

    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.text=icon?.name
        }
    }

    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text=icon?.description
        }
    }
    
    @IBOutlet var priceLabel: UILabel! {
        didSet {
            if let icon=icon {
                priceLabel.text="$\(icon.price)"
            }
        }
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
