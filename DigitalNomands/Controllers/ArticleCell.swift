//
//  ArticleCell.swift
//  DigitalNomands
//
//  Created by Viktor on 19.01.2021.
//

import UIKit
import SDWebImage

class ArticleCell: UITableViewCell {
    static var reuseID: String = "ArticleCell"
    
    //First layer
    let cardView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let articleImageView = UIImageView()
    let articleTitle = UILabel(text: "¿Estás buscando nuevos fondos de pantalla para modificar el aspecto de tu móvil? Te recomendamos los mejores sitios para descargar fondos de calidad.", font: .laoSangamMN20)
    let publishedAtLabel = UILabel(text: "2021-01-19 10:02", font: .laoSangamMN18)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .mainWhite
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with article: Article) {
        articleTitle.text = article.title
        publishedAtLabel.text = article.publishedAt.dateAndTimetoString()
        articleImageView.sd_setImage(with: URL(string: (article.urlToImage)))
    }
    
    override func prepareForReuse() {
        articleImageView.image = nil
    }
}

// MARK: - Setup constraints
extension ArticleCell {
    private func setupConstraints() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        publishedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        articleImageView.backgroundColor = .orange
        
        addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            cardView.heightAnchor.constraint(equalToConstant: 125),
        ])
        
        
        
        
        
        //        addSubview(articleImageView)
        ////        addSubview(articleTitle)
        ////        addSubview(publishedAtLabel)
        //
        //        NSLayoutConstraint.activate([
        //            articleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        //            articleImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        //            articleImageView.heightAnchor.constraint(equalToConstant: 190),
        //            articleImageView.widthAnchor.constraint(equalToConstant: 190)
        //        ])
        
        //        NSLayoutConstraint.activate([
        //            friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
        //            friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
        //            friendName.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16)
        //        ])
        //
        //        NSLayoutConstraint.activate([
        //            publishedAtLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
        //            publishedAtLabel.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
        //            publishedAtLabel.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16)
        //        ])
        
        
    }
}

//MARK: - SwiftUI
import SwiftUI
struct ArticleCellProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController = MainViewController()
        
        func makeUIViewController(context: Context) -> MainViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: MainViewController, context: Context) {}
    }
}
