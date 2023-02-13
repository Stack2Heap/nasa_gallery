
import SwiftUI

class SpaceViewModel {
    
    let imageCache = NSCache<NSString, UIImage>()
    let metaDataCache = NSCache<NSString, StructWrapper<APODInstance>>()
    let cache = NSCache<NSString, CachedSpaceModel>()
    
    func fetchImageOfTheDay() async throws -> (APODInstance, UIImage) {
                
        guard let cachedModel = cache.object(forKey: metaDataCacheKey()), let currentAPODOfTheDay = cachedModel.avatar else {
            // load image & meta data from NASA server
            let (apodData, _) = try await URLSession.shared.data(from: generateNASAQueryURL())
            let currentAPODOfTheDay = try JSONDecoder().decode(APODInstance.self, from: apodData)
            let (imageData, _) = try await URLSession.shared.data(from: URL(string: currentAPODOfTheDay.url)!)
            let currentImageOfTheDay = UIImage(data: imageData) ?? UIImage(named: "nasa-logo")!
            cacheData(metaData: currentAPODOfTheDay, image: currentImageOfTheDay)
            return (currentAPODOfTheDay, currentImageOfTheDay)
        }
        // retrieves image & meta data if already available in cache
        return (cachedModel.structWrapper.value, currentAPODOfTheDay)
    }
                                             
    private func metaDataCacheKey() -> NSString {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date()) as NSString
    }
    
    private func cacheData(metaData: APODInstance, image: UIImage) {
        // same image and meta data available in cache
        let cacheModel = CachedSpaceModel(wrapper: StructWrapper(metaData), image: image)
        cache.countLimit = 1
        cache.setObject(cacheModel, forKey: metaDataCacheKey())
    }
    
    private func generateNASAQueryURL() -> URL {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date().dayBefore)
        
        let queryItems = [URLQueryItem(name: "api_key", value: AppConstants.defaultAPIKey), URLQueryItem(name: "date", value:  dateString)]
        var urlComps = URLComponents(string: AppConstants.defaultNASAUrl)!
        urlComps.queryItems = queryItems
        return urlComps.url!
    }
}
