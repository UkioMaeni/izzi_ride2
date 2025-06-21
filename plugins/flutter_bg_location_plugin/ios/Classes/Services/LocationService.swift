import CoreLocation
import BackgroundTasks
import UIKit
/// Сервис локации
public class LocationService: NSObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()
 

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = false
    }

    public func locationManager(_ mgr: CLLocationManager, didUpdateLocations locs: [CLLocation]) {
        print("locationManager")
        guard let loc = locs.last else { return }
        sendLocation(loc)

    }

   public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error)")
    }
    
    private func sendLocation(_ loc: CLLocation) {
        print("LocationService tick lat \(loc.coordinate.latitude)")
        print("LocationService tick lon \(loc.coordinate.longitude)")
        guard let url = URL(string: "https://webhook-test.com/d8d9cf174da6970ecf6526b231792c54") else { return }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try? JSONSerialization.data(withJSONObject: ["platform": "ios", "loc": "\(loc.coordinate.longitude)","lat": "\(loc.coordinate.latitude)"])
        URLSession.shared.dataTask(with: req) { _, response, error in
        if let err = error {
            NSLog("[Loc] POST error: %@", err.localizedDescription)
            return
        }
        if let http = response as? HTTPURLResponse,
           !(200...299).contains(http.statusCode) {
            NSLog("[Loc] POST failed HTTP %d", http.statusCode)
        } else {
            NSLog("[Loc] POST ok (%.6f, %.6f)",
                  loc.coordinate.latitude,
                  loc.coordinate.longitude)
        }
    }.resume()                     
    }

    @discardableResult
    func startTracking(seconds: Int, hash: String, orderId: Int) -> Bool {
        print("startTracking")
        guard CLLocationManager.authorizationStatus() == .authorizedAlways else {
            NSLog("[Loc] no Always permission")
            return false
        }
        manager.allowsBackgroundLocationUpdates = true
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        return true
    }

    @discardableResult
    func stopTracking() -> Bool {
        print("stopTracking")
        
        manager.stopUpdatingLocation()
        return true;
    }
}

