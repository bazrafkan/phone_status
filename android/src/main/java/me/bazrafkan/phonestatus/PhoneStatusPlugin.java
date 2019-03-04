package me.bazrafkan.phonestatus;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.EventChannel;
import android.content.Context;
import android.provider.CallLog;
import android.database.ContentObserver;
import android.net.Uri;
import android.provider.ContactsContract;
import android.provider.Telephony;

/** PhoneStatusPlugin */
public class PhoneStatusPlugin implements EventChannel.StreamHandler  {
  private static EventChannel.EventSink _events ;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final EventChannel phoneStateChannel = new EventChannel(registrar.messenger(), "phone_status");
    phoneStateChannel.setStreamHandler(new PhoneStatusPlugin(registrar.context()));
  }

  private PhoneStatusPlugin(Context context) {
    context.getContentResolver().registerContentObserver(CallLog.Calls.CONTENT_URI, true,
            new callLogChanged());
    context.getContentResolver().registerContentObserver(ContactsContract.Contacts.CONTENT_URI, true,
            new contactChanged());
    context.getContentResolver().registerContentObserver(Telephony.Sms.CONTENT_URI, true,
            new smsChanged());
  }

  @Override
  public void onListen(Object arguments, EventChannel.EventSink events) {
    _events=events;
  }

  @Override
  public void onCancel(Object arguments) {
    _events=null;
  }

  protected class callLogChanged extends ContentObserver {
    public callLogChanged() {
      super(null);
    }

    @Override
    public void onChange(boolean selfChange, Uri uri) {
      super.onChange(selfChange,uri);
      if ( _events != null){
        _events.success("CALL");
      }
    }
  }

  protected class contactChanged extends ContentObserver {

    public contactChanged() {
      super(null);
    }

    @Override
    public void onChange(boolean selfChange, Uri uri) {
      super.onChange(selfChange,uri);
      if ( _events != null){
        _events.success("CONTACT");
      }
    }
  }

  protected class smsChanged extends ContentObserver {

    public smsChanged() {
      super(null);
    }

    @Override
    public void onChange(boolean selfChange, Uri uri) {
      super.onChange(selfChange,uri);
      if ( _events != null){
        _events.success("SMS");
      }
    }
  }
}
