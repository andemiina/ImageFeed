//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Анна Демина on 04.09.2024.
//


//контейнер для хранения всех свойств кастомной ячейки
import UIKit


final class ImagesListCell: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    static let reuseIdentifier = "ImagesListCell"
    
    
}
