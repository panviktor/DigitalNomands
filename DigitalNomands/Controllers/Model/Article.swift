//
//  Article.swift
//  DigitalNomands
//
//  Created by Viktor on 18.01.2021.
//

import Foundation

struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    var normalPublishedDate: String {
        let date = Date.dateFromString(date: publishedAt ?? "2021-01-19T10:02:44Z")
        return Date.dateAndTimetoString(date: date)
    }
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case articleDescription = "description"
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    static var mocArticle = Article(source: Source(id: nil, name: "Tuexperto.com"),
                                    author: "Sergio Asenjo",
                                    title: "10 recursos para descargar fondos de pantalla para tu móvil",
                                    articleDescription: "¿Estás buscando nuevos fondos de pantalla para modificar el aspecto de tu móvil? Te recomendamos los mejores sitios para descargar fondos de calidad.",
                                    url: "https://www.tuexperto.com/2021/01/19/10-recursos-para-descargar-fondos-de-pantalla-para-tu-movil/",
                                    urlToImage: "https://www.tuexperto.com/wp-content/uploads/2021/01/10-recursos-para-descargar-fondos-de-pantalla-para-tu-movil.jpg",
                                    publishedAt: "2021-01-19T10:02:44Z",
                                    content: "Si te has aburrido del fondo de pantalla de tu móvil y estás buscando alternativas, es probable que te interese conocer algunas de las mejores páginas web o aplicaciones para descargar nuevos fondos … [+5877 chars]")
}
