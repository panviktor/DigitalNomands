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
    private let cardView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.9098562598, green: 0.9044476748, blue: 0.914013803, alpha: 1)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let articleTitle: UILabel = {
        let label = UILabel(text: "¿Estás buscando nuevos fondos de pantalla para modificar el aspecto de tu móvil? Te recomendamos los mejores sitios para descargar fondos de calidad.", font: .laoSangamMN20)
        label.numberOfLines = 3
        return label
    }()
    
    private let articleImageView = UIImageView()
    private let publishedAtLabel = UILabel(text: "2021-01-19 10:02", font: .avenir15)
    private let authorLabel = UILabel(text: "Sergio Asenjo", font: .laoSangamMN18)
    
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
        authorLabel.text = article.author
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
            cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2.5),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2.5),
            cardView.heightAnchor.constraint(equalToConstant: 125),
        ])
        
        cardView.addSubview(articleImageView)
        NSLayoutConstraint.activate([
            articleImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5),
            articleImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 5),
            articleImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5),
            articleImageView.heightAnchor.constraint(equalToConstant: 120),
            articleImageView.widthAnchor.constraint(equalToConstant: 120),
        ])
        
        cardView.addSubview(articleTitle)
        NSLayoutConstraint.activate([
            articleTitle.topAnchor.constraint(equalTo: articleImageView.topAnchor, constant: 2.5),
            articleTitle.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 2.5),
            articleTitle.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -2.5),
        ])
        
        let horizontalStackView = UIStackView(arrangedSubviews: [publishedAtLabel, authorLabel], axis: .horizontal, spacing: 10)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.alignment = .firstBaseline
        cardView.addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(greaterThanOrEqualTo: articleTitle.bottomAnchor, constant: 2.5),
            horizontalStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -2.5),
            horizontalStackView.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 5),
            horizontalStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5.5),
        ])
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
