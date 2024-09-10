//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Анна Демина on 10.09.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    var image: UIImage? {
          didSet {
              guard isViewLoaded else { return } // 1
              imageView.image = image // 2
          }
      }
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
          super.viewDidLoad()
          imageView.image = image
      }
    
}
