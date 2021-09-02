import Flutter
import UIKit
import UserNotifications
import AVFoundation

public class SwiftCallNotificationPlugin: NSObject, FlutterPlugin,UNUserNotificationCenterDelegate{
    var methodChannel : FlutterMethodChannel?
    var avPlayer : AVAudioPlayer?
    public let notificationIdentifier = "Call Notification";
    public let notificationStatus = "CallNotifications";
 
    public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "call_notification", binaryMessenger: registrar.messenger())
        let instance = SwiftCallNotificationPlugin()
    askNotificationPermission()
        instance.initilizeFlutterPlugin(registrar : registrar,channel : channel)
  }
    
    public func initilizeFlutterPlugin(registrar: FlutterPluginRegistrar, channel: FlutterMethodChannel) {
        self.methodChannel = channel;
        registrar.addMethodCallDelegate(self, channel: self.methodChannel!)
        registrar.addApplicationDelegate(self)
    }
    
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    public func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) -> Bool {
        return true
    }
    
    private static func askNotificationPermission(){
        let userNotificationCenter = UNUserNotificationCenter.current();
        userNotificationCenter.requestAuthorization(options: [.alert,.sound], completionHandler: {(granded,error) in })
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo as! Dictionary<String,Any>
        self.methodChannel?.invokeMethod(CallNotificationChannel.ReceivedAction, arguments: NotificationBuilder.buildLaunchNotificationAction(notificationData:userInfo).toMap())
        completionHandler()
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "showNotification"){
        let callData = CallNotificationData.init(json: call.arguments as! Dictionary<String,Any>)
        showNotification(notificationData: callData);
    } else if (call.method == "cancelCallNotification"){
        cancelNotification();
    } else if (call.method == "showUnhandledPressedAction"){
        print("showUnhandledPressedAction");
    } else if (call.method == "isNotificationEnabled"){
        let status = self.getCurrentNotificationStatus();
        result(status)
    } else {
        result("Not implemented")
    }
  }
    
    private func cancelNotification(){
        avPlayer?.stop()
        self.setNotificationStatus(status: false)
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notificationIdentifier])
    }
    
    private func showNotification(notificationData : CallNotificationData) {
        let userNotificationCenter = UNUserNotificationCenter.current();
        
        let notificationContent = UNMutableNotificationContent();
        notificationContent.title = notificationData.callerName
        notificationContent.body = "is calling"
        notificationContent.userInfo = notificationData.toMap()
        
        if(notificationData.isBackgroundNotification) {
            if #available(iOS 12.0, *) {
                notificationContent.sound = UNNotificationSound.defaultCritical
            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request, withCompletionHandler:{(err) in
            if(notificationData.isBackgroundNotification == false){
                self.playAudio()
            }
        })
        
        self.setNotificationStatus(status: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(notificationData.notificationDuration)) {
            self.cancelNotification()
        }
    }
    
    func playAudio(){
        let url = Bundle.main.url(forResource: "ringTone", withExtension: "mp3")
        if(url != nil){
            do {
                self.avPlayer = try AVAudioPlayer(contentsOf: url!)
                self.avPlayer?.prepareToPlay()
                self.avPlayer?.play();
                
                let audioSession = AVAudioSession.sharedInstance()
                
                do {
                    try audioSession.setCategory(AVAudioSession.Category.playback,options: AVAudioSession.CategoryOptions.mixWithOthers)
                    try audioSession.setActive(true)
                } catch {
                    print(error)
                }
            } catch {
                print(error);
            }
        }
    }
    
    private func getCurrentNotificationStatus() -> Bool {
        let preferences = UserDefaults.standard;
        preferences.register(defaults: [notificationStatus : false])
        let status  = preferences.bool(forKey: notificationStatus)
        return status
    }
    
    private func setNotificationStatus(status : Bool) {
        let preferences = UserDefaults.standard;
        preferences.setValue(status, forKey: notificationStatus)
        preferences.synchronize()
    }
}
