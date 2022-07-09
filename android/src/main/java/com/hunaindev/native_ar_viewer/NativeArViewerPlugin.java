package com.hunaindev.native_ar_viewer;

import android.content.ActivityNotFoundException;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import androidx.annotation.NonNull;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** NativeArViewerPlugin */
public class NativeArViewerPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "native_ar_viewer");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("launchAR")) {
      startActivity(call, result);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    context = null;
  }

  private void startActivity(MethodCall call, Result result) {
    try {
    final String data = call.argument("data");

    final Intent intent = new Intent();
    intent.setAction("android.intent.action.VIEW");
    intent.setPackage("com.google.ar.core");
    intent.addFlags(0x10000000);
    intent.setDataAndNormalize(Uri.parse(data));
    
    context.startActivity(intent);
    result.success(true);
    }
    catch (final ActivityNotFoundException error) {
      result.success(false);
    }
  }
}
