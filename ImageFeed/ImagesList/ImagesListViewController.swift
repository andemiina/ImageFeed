//
//  ViewController.swift
//  ImageFeed
//
//  Created by Анна Демина on 04.09.2024.
//

import UIKit

final class ImagesListViewController: UIViewController {
    private let showSingleImageSegueIdentifier = "ShowSingleImage"

    @IBOutlet private var tableView: UITableView!
    //создает массив чисел от 0 до 19 и возвращает массив строк
    private let photosName: [String] = Array(0..<20).map{ "\($0)" }
    
    //форматирует дату на экране
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //выстраивает отступы краев у таблицы
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == showSingleImageSegueIdentifier { // 1
                guard
                    let viewController = segue.destination as? SingleImageViewController, // 2
                    let indexPath = sender as? IndexPath // 3
                else {
                    assertionFailure("Invalid segue destination") // 4
                    return
                }

                let image = UIImage(named: photosName[indexPath.row]) // 5
                _ = viewController.view 
                viewController.imageView.image = image // 6
            } else {
                super.prepare(for: segue, sender: sender) // 7
            }
        }
    
}

extension ImagesListViewController: UITableViewDelegate {
    //отвечает за действия, которые будут при тапе на ячейку таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return 0
        }
        
        //расчитываем высоту ячейки с фото
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
}


extension ImagesListViewController: UITableViewDataSource {
    
    //определяет количество ячеек в секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    //возвращает ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //использовали идентификатор, который из всех ячеек возвращает только ту, которую задали по заранее добаенному идентификатору
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        //провели приведение типов, если что-то пойдет не так, то мы вернем обычную ячейку
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)
        
        //возвращаем ячейку
        return imageListCell
    }
}


extension ImagesListViewController {
    //настраиваем ячейку(добавляем изображение/дату/лайк)
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        //проверяем есть ли изображение, если нет, то ничего не возвращаем
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        }
        
        cell.cellImage.image = image
        cell.dateLabel.text = dateFormatter.string(from: Date())
        let isLiked = indexPath.row % 2 == 1
        let likeImage = isLiked ? UIImage(named: "Active") : UIImage(named: "No Active")
        cell.likeButton.setImage(likeImage, for: .normal)
    }
}
