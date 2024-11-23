//
//  ImageView+Extension.swift
//  Digio
//
//  Created by Marcio Habigzang Brufatto on 23/11/24.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeHolder: UIImage? = UIImage(named: "no_image")) {
        DispatchQueue.main.async {
            self.image = placeHolder
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Erro ao carregar imagem: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Erro: Dados de imagem inválidos")
                DispatchQueue.main.async {
                    self?.image = placeHolder
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
    }
}
