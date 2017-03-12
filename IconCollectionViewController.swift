//
//  IconCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Slawek Kurczewski on 09.03.2017.
//  Copyright © 2017 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import Social

private let reuseIdentifier = "Cell"

class IconCollectionViewController: UICollectionViewController {
    
    private var shareEnabled = false
    private var selectedIcons: [Icon] = []
    
    @IBOutlet var shareButton: UIBarButtonItem!
    private var iconSet: [Icon] =
        [Icon(name:	"candle",           price:	3.99,   isFeatured:	false),
         Icon(name:	"cat",              price:	2.99,	isFeatured:	true ),
         Icon(name:	"dribbble",         price:	1.99,	isFeatured:	false),
         Icon(name:	"ghost",            price:	4.99,	isFeatured:	false),
         Icon(name:	"hat",              price:	2.99,	isFeatured:	false),
         Icon(name:	"owl",              price:	5.99,	isFeatured:	true ),
         Icon(name:	"pot",              price:	1.99,	isFeatured:	false),
         Icon(name:	"pumkin",           price:	0.99,	isFeatured:	false),
         Icon(name:	"rip",              price:	7.99,	isFeatured:	false),
         Icon(name:	"skull",            price:	8.99,	isFeatured:	false),
         Icon(name:	"sky",              price:	0.99,	isFeatured: false),
         Icon(name:	"toxic",            price:	2.99,	isFeatured:	false),
         Icon(name:	"ic_book",          price:	2.99,	isFeatured:	false),
         Icon(name:	"ic_backpack",      price:	3.99,	isFeatured:	false),
         Icon(name:	"ic_camera",        price:	4.99,	isFeatured:	false),
         Icon(name:	"ic_coffee",        price:	3.99,	isFeatured:	true ),
         Icon(name:	"ic_glasses",       price:	3.99,	isFeatured:	false),
         Icon(name:	"ic_ice_cream",     price:	4.99,	isFeatured:	false),
         Icon(name:	"ic_smoking_pipe",	price:	6.99,	isFeatured:	false),
         Icon(name:	"ic_vespa",         price:	9.99,	isFeatured:	false)]

    @IBAction func shareButtonTapped(_ sender: AnyObject) {
        if shareEnabled {
        // wysłanie postu do FB
            if selectedIcons.count > 0 {
                if (SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter))
                {
                    let twittComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                    twittComposer?.setInitialText("Love these icons! I bay thtem")
                    for icon in selectedIcons {
                        twittComposer?.add(UIImage(named: icon.name))
                        
                    }
                    present(twittComposer!, animated: true, completion: nil)
                }
            }
        // odznacz wszystkie
        if let indexPaths=collectionView?.indexPathsForSelectedItems {
            for indexPath in indexPaths {
                collectionView?.deselectItem(at: indexPath, animated: false)
            }
        }
        // usuwa wszystkie zaznaczone elementy
        selectedIcons.removeAll(keepingCapacity: true)
        
        // zmienie tryb Share na No
        shareEnabled=false
        collectionView?.allowsMultipleSelection=false
        shareButton.title="Share"
        shareButton.style=UIBarButtonItemStyle.plain
    }
    else
    {
        shareEnabled=true
        collectionView?.allowsMultipleSelection=true
        shareButton.title="Done"
        shareButton.style=UIBarButtonItemStyle.done
    }
        //--------------  todoo
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        // usunieto
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//collectionView(_:numberOfItemsInSection:)

//collectionView(_:cellForItemAt:)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

     override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return iconSet.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! IconCollectionViewCell
    
        // Configure the cell
        let icon=iconSet[indexPath.row]
        //cell.contentView.backgroundColor=UIColor.gray
        // cell.backgroundView?.backgroundColor=UIColor.green
        //cell.selectedBackgroundView?.backgroundColor=UIColor.red
        cell.backgroundView=(icon.isFeatured) ? UIImageView(image: UIImage(named: "feature-bg")) : nil
        
        cell.selectedBackgroundView=UIImageView(image: UIImage(named: "selected-bg"))
        
        
        cell.iconImageView.image=UIImage(named: icon.name)
        cell.iconPrinceLabel.text="$\(icon.price)"
    
        return cell
    }
    func unwindToHome(segue: UIStoryboardSegue){
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="showIconDetail")
        {
            // daje tablice indexPath do kolejnych sekcji
            if let indexPaths = collectionView?.indexPathsForSelectedItems {
                let destinationController = segue.destination as! IconDetailViewController
                // podstawia wszystkie dane za jednym razem
                destinationController.icon=iconSet[indexPaths[0].row]
                collectionView?.deselectItem(at: indexPaths[0], animated: false)
            
            }
        }

    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier=="showIconDetail"{
            if shareEnabled { return false }
        }
        return true
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // sprawdza czy tryb udostepniania jest włączony, w przeciwnym wypadku opuszcza metodę
        guard shareEnabled else {
            return
        }
        // określa listę wybranych używanych przezindexPath
        let selectedIcon = iconSet[indexPath.row]
        
        // dodaje wybrany element do tablicy
        selectedIcons.append(selectedIcon)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // sprawdza czy tryb udostepniania jest włączony, w przeciwnym wypadku opuszcza metodę
        guard shareEnabled else {
            return
        }
        let deSelectedIcon = iconSet[indexPath.row]
        // w closure porównujemy nazwę odznaczonej ikony i wyszukujemy jej indeks
        if let index = selectedIcons.index(where: { $0.name==deSelectedIcon.name     })
        {
            selectedIcons.remove(at: index)
        }
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
