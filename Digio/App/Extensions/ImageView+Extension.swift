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
            if error != nil { return }
            
            guard let data = data, let image = UIImage(data: data) else {
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
