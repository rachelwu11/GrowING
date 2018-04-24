//
//  ViewController.swift
//  GrowING
//
//  Created by Rachel Wu on 4/22/18.
//  Copyright © 2018 Rachel Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let image = UIImage(named: "bag1"), let scaledImage = image.scaleImageToFitScreen() else {
            return
        }
        
        let holder = UIView(frame: CGRect(x: 0, y: 100, width: scaledImage.size.width, height: scaledImage.size.height))
        splitImage(image: scaledImage, row: 3, colum: 3, insideView: holder)
    }
    
    private func splitImage(image: UIImage, row: Int, colum: Int, insideView: UIView) {
        let imageSize = image.size
        var xPos: CGFloat = 0.0
        var yPos: CGFloat = 0.0
        let width: CGFloat = imageSize.width / CGFloat(colum)
        let height: CGFloat = imageSize.height / CGFloat(row)
        for aIntY in 0..<row {
            xPos = 0.0
            for aIntX in 0..<colum {
                let rect = CGRect(x: xPos, y: yPos, width: width, height: height)
                let cImage: CGImage = (image.cgImage?.cropping(to: rect))!
                let aImgRef = UIImage(cgImage: cImage)
                let aImgView = UIImageView(frame: CGRect(x: CGFloat(aIntX) * insideView.frame.size.width/CGFloat(colum), y: CGFloat(aIntY)*insideView.frame.size.height/CGFloat(row), width: insideView.frame.size.width/CGFloat(colum), height: insideView.frame.size.height/CGFloat(row)))
                aImgView.image = aImgRef
                aImgView.layer.borderColor = UIColor.black.cgColor
                aImgView.layer.borderWidth = 0.5
                insideView.addSubview(aImgView)
                xPos += width
            }
            yPos += height
        }
        view.addSubview(insideView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIImage {
    func scaleImageToFitScreen() -> UIImage? {
        let imageRatio: CGFloat = self.size.width / self.size.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenRatio: CGFloat = screenWidth / screenHeight
        var newSize: CGSize = CGSize.zero
        if imageRatio > screenRatio {
            let newHeight = self.size.height * screenWidth / self.size.width
            newSize = CGSize(width: screenWidth, height: newHeight)
        } else {
            let newWidth = self.size.width * screenHeight / self.size.height
            newSize = CGSize(width: newWidth, height: screenHeight)
        }
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
