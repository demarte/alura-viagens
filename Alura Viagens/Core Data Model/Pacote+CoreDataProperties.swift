//
//  Pacote+CoreDataProperties.swift
//  Alura Viagens
//
//  Created by Ivan De Martino on 3/11/19.
//  Copyright © 2019 Alura. All rights reserved.
//
//

import Foundation
import CoreData


extension Pacote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pacote> {
        return NSFetchRequest<Pacote>(entityName: "Pacote")
    }

    @NSManaged public var caminhoDaImagem: String
    @NSManaged public var dataViagem: String
    @NSManaged public var preco: String
    @NSManaged public var quantidadeDeDias: Int16
    @NSManaged public var servico: String
    @NSManaged public var titulo: String
    @NSManaged public var id: Int64

}
