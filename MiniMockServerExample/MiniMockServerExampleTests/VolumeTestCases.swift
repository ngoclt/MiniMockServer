//
//  VolumeTestCases.swift
//  GBookTests
//
//  Created by Extra Computer on 10/05/2019.
//  Copyright © 2019 Ngoc LE. All rights reserved.
//

import Foundation

enum VolumeTestCases: String {
    case validVolumeJSON = "{\"kind\":\"books#volume\",\"id\":\"BbjUDAAAQBAJ\",\"etag\":\"+CNip/ISngs\",\"selfLink\":\"https://www.googleapis.com/books/v1/volumes/BbjUDAAAQBAJ\",\"volumeInfo\":{\"title\":\"Harry Potter ja viisasten kivi\",\"authors\":[\"J.K. Rowling\"],\"publisher\":\"Pottermore Publishing\",\"publishedDate\":\"2016-08-23\",\"description\":\"Kun Harry käänsi kirjekuoren vapisevin käsin ympäri, hän näki purppuranpunaisen vahasinetin, jossa oli vaakuna: leijona, kotka, mäyrä ja käärme ison T-kirjaimen ympärillä. Harry Potter ei ole koskaan kuullutkaan Tylypahkasta kun kirjeitä alkaa sadella sisään Likusteritie 4:n postiluukusta. Harryn karmea setä ja täti takavarikoivat pikaisesti kellertävälle pergamenttipaperille vihreällä musteella kirjoitetut kirjeet. Sitten, Harryn 11. syntymäpäivänä, koppakuoriaissilmäinen ja jättikokoinen mies nimeltä Rubeus Hagrid paukahtaa ovesta sisään hämmentävien uutisten kera: Harry Potter on velho, ja hänelle on varattu paikka Tylypahkan noitien ja velhojen koulusta. Uskomaton seikkailu on alkamassa!\",\"industryIdentifiers\":[{\"type\":\"ISBN_13\",\"identifier\":\"9781781101803\"},{\"type\":\"ISBN_10\",\"identifier\":\"1781101809\"}],\"readingModes\":{\"text\":true,\"image\":true},\"pageCount\":335,\"printType\":\"BOOK\",\"categories\":[\"Juvenile Fiction\"],\"averageRating\":4.0,\"ratingsCount\":7,\"maturityRating\":\"NOT_MATURE\",\"allowAnonLogging\":true,\"contentVersion\":\"1.6.7.0.preview.3\",\"panelizationSummary\":{\"containsEpubBubbles\":false,\"containsImageBubbles\":false},\"imageLinks\":{\"smallThumbnail\":\"http://books.google.com/books/content?id=BbjUDAAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api\",\"thumbnail\":\"http://books.google.com/books/content?id=BbjUDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api\"},\"language\":\"fi\",\"previewLink\":\"http://books.google.fi/books?id=BbjUDAAAQBAJ&printsec=frontcover&dq=Harry+Potter&hl=&cd=1&source=gbs_api\",\"infoLink\":\"https://play.google.com/store/books/details?id=BbjUDAAAQBAJ&source=gbs_api\",\"canonicalVolumeLink\":\"https://market.android.com/details?id=book-BbjUDAAAQBAJ\"},\"saleInfo\":{\"country\":\"FI\",\"saleability\":\"FOR_SALE\",\"isEbook\":true,\"listPrice\":{\"amount\":8.99,\"currencyCode\":\"EUR\"},\"retailPrice\":{\"amount\":8.99,\"currencyCode\":\"EUR\"},\"buyLink\":\"https://play.google.com/store/books/details?id=BbjUDAAAQBAJ&rdid=book-BbjUDAAAQBAJ&rdot=1&source=gbs_api\",\"offers\":[{\"finskyOfferType\":1,\"listPrice\":{\"amountInMicros\":8990000,\"currencyCode\":\"EUR\"},\"retailPrice\":{\"amountInMicros\":8990000,\"currencyCode\":\"EUR\"}}]}}"
    
    func object<T: Decodable>() -> T? {
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: self.rawValue.data(using: .utf8)!)
            return model
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
