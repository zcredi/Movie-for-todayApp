import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSURL, UIImage>()

    private init() {}

    func downloadImage(from url: URL, imageSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        // Проверка наличия изображения в кэше
        if let cachedImage = cache.object(forKey: url as NSURL) {
            print("Cached image")
            completion(cachedImage)
            return
        }

        // Загрузка изображения, если его нет в кэше
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                // Масштабирование изображения перед сохранением в кэш
                let scaledImage = self.scaleImage(image, toSize: imageSize)
                
                self.cache.setObject(scaledImage, forKey: url as NSURL)
                DispatchQueue.main.async {
                    completion(scaledImage)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

    // Масштабирование изображения до нового размера, сохраняя соотношение сторон
    private func scaleImage(_ image: UIImage, toSize newSize: CGSize) -> UIImage {
        let aspectWidth = newSize.width / image.size.width
        let aspectHeight = newSize.height / image.size.height
        let aspectRatio = min(aspectWidth, aspectHeight)

        let scaledSize = CGSize(width: image.size.width * aspectRatio, height: image.size.height * aspectRatio)
        let renderer = UIGraphicsImageRenderer(size: scaledSize)

        let scaledImage = renderer.image { context in
            image.draw(in: CGRect(origin: .zero, size: scaledSize))
        }

        return scaledImage
    }
}
