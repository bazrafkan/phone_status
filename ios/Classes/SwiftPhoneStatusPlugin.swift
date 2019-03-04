import Flutter
import UIKit
import CallKit

@available(iOS 10.0, *)
public class SwiftPhoneStatusPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
  private var eventSink: FlutterEventSink?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let eventchannel = FlutterEventChannel(name: "phone_status", binaryMessenger: registrar.messenger())
    let instance = SwiftPhoneStatusPlugin()
     eventchannel.setStreamHandler(instance)
     
     
  }


  public func onListen(withArguments arguments: Any?,
                       eventSink: @escaping FlutterEventSink) -> FlutterError? {
                         self.eventSink = eventSink 
    return nil
  }
  
  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    return nil
  }
}
