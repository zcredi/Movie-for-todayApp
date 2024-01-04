//
//  SearchTableView.swift
//  Movie for todayApp
//
//  Created by Дмитрий on 04.01.2024.
//

import UIKit
// 1. Создаем кастомный класс UITableViewCell
class SearchTableView: UITableViewCell {
    
    let cellImageView: UIImageView = {
        let cellImage = UIImageView()
        cellImage.image = UIImage(systemName: "figure.equestrian.sports")
        return cellImage
    }()
    let movieName: UILabel = {
        let title = UILabel()
        title.text = "Spider man"
        return title
    }()
    let year: UILabel = {
        let title = UILabel()
        title.text = "2015"
        return title
    }()
    let duration: UILabel = {
        let title = UILabel()
        title.text = "140"
        return title
    }()
    let genre: UILabel = {
        let title = UILabel()
        title.text = "Action"
        return title
    }()
    
    let typeOfMovie: UILabel = {
        let title = UILabel()
        title.font = .montserratMedium12()
        title.text = "Movie"
        return title
    }()
    //let subtitleLabel4 = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupView()
        // Добавляем элементы в contentView
        
        //contentView.addSubview(subtitleLabel4)
        
        // Здесь настройте Auto Layout или фреймы
        // Например, используя Auto Layout anchors...
        // cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        // ...
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView () {
        [cellImageView, movieName, year, duration, genre, typeOfMovie].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
    }
        func setupConstraints () {
            
            NSLayoutConstraint.activate([
                cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                cellImageView.widthAnchor.constraint(equalToConstant: 110),
                cellImageView.heightAnchor.constraint(equalToConstant: 150),
                
                movieName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: -20),
                movieName.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 13),
                
                year.topAnchor.constraint(equalTo: contentView.topAnchor,constant: -54),
                year.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 13),
                
                duration.topAnchor.constraint(equalTo: contentView.topAnchor,constant: -83),
                duration.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 13),
                
                genre.topAnchor.constraint(equalTo: contentView.topAnchor,constant: -110),
                genre.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 13),
                
                typeOfMovie.leadingAnchor.constraint(equalTo: genre.trailingAnchor, constant: 16),
                typeOfMovie.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -110)
                
            ])
        }
        // Функция для конфигурации ячейки с данными
        func configureWith(image: UIImage?, title: String, subtitles: [UILabel]) {
            cellImageView.image = image
            movieName.text = title
            // Задайте текст для subtitleLabels...
        }
    }
    
    // 2. Регистрируем кастомную ячейку в вашем UITableViewController
    class MyTableViewController: UITableViewController {
       let tableViewCell = SearchTableView()
        override func viewDidLoad() {
            super.viewDidLoad()
            tableView.register(SearchTableView.self, forCellReuseIdentifier: "CustomTableViewCell")
        }
        
        // 3. DataSource методы
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Верните количество строк, которое вы хотите отобразить
            return 1
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! SearchTableView
            
            // Конфигурируем ячейку с данными
            let image = UIImage(systemName: "figure.equestrian.sports")// Получите изображение для ячейки
            let title = "ss" // Получите заголовок
            let subtitles = [tableViewCell.movieName, tableViewCell.year, tableViewCell.duration,tableViewCell.genre, tableViewCell.typeOfMovie]// Получите подзаголовки
            cell.configureWith(image: image, title: title, subtitles: subtitles)
            
            return cell
        }
    }
