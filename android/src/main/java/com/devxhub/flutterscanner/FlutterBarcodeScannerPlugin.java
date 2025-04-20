package com.devxhub.flutterscanner;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;

import com.google.android.gms.common.api.CommonStatusCodes;
import com.google.android.gms.vision.barcode.Barcode;

import java.util.Map;

import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.embedding.engine.plugins.lifecycle.FlutterLifecycleAdapter;

public class FlutterBarcodeScannerPlugin implements MethodCallHandler, PluginRegistry.ActivityResultListener, EventChannel.StreamHandler, FlutterPlugin, ActivityAware {
    private static final String CHANNEL = "flutter_scanner_devxhub";
    private static final String TAG = FlutterBarcodeScannerPlugin.class.getSimpleName();
    private static final int RC_BARCODE_CAPTURE = 9001;

    // Configuration variables
    public static String lineColor = "";
    public static String flashIconPath = "";
    public static String flashOffIconPath = "";
    public static String changeCameraIconPath = "";
    public static String changeInputIconPath = "";
    public static boolean isShowFlashIcon = false;
    public static boolean isShowInputIcon = false;
    public static boolean isOrientationLandscape = false;
    public static boolean isNeedLengthCondition = false;
    public static boolean isNeedOnlyDigitCondition = false;
    public static boolean isContinuousScan = false;
    public static String minimunLengthMinusOne = "";
    public static String maximunLengthPlusOne = "";
    public static String iconSize = "";
    public static String fontSize = "";
    public static String duration = "";

    // Flutter plugin state
    private static FlutterFragmentActivity activity;
    private static Result pendingResult;
    private Map<String, Object> arguments;
    private static EventChannel.EventSink barcodeStream;
    private MethodChannel channel;
    private EventChannel eventChannel;
    private FlutterPluginBinding pluginBinding;
    private ActivityPluginBinding activityBinding;
    private Lifecycle lifecycle;
    private LifeCycleObserver observer;

    public FlutterBarcodeScannerPlugin() {
        // Default constructor required
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        pluginBinding = binding;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        pluginBinding = null;
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        setupPlugin(binding);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        tearDownPlugin();
    }

    private void setupPlugin(ActivityPluginBinding binding) {
        activityBinding = binding;
        activity = (FlutterFragmentActivity) binding.getActivity();

        // Setup method channel
        channel = new MethodChannel(pluginBinding.getBinaryMessenger(), CHANNEL);
        channel.setMethodCallHandler(this);

        // Setup event channel
        eventChannel = new EventChannel(pluginBinding.getBinaryMessenger(), "flutter_scanner_devxhub_receiver");
        eventChannel.setStreamHandler(this);

        // Setup lifecycle
        lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding);
        observer = new LifeCycleObserver();
        lifecycle.addObserver(observer);

        // Add activity result listener
        binding.addActivityResultListener(this);
    }

    private void tearDownPlugin() {
        if (activityBinding != null) {
            activityBinding.removeActivityResultListener(this);
        }
        if (channel != null) {
            channel.setMethodCallHandler(null);
        }
        if (eventChannel != null) {
            eventChannel.setStreamHandler(null);
        }
        if (lifecycle != null && observer != null) {
            lifecycle.removeObserver(observer);
        }

        activityBinding = null;
        lifecycle = null;
        activity = null;
        pendingResult = null;
        arguments = null;
        barcodeStream = null;
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        pendingResult = result;

        if (call.method.equals("scanBarcode")) {
            try {
                if (!(call.arguments instanceof Map)) {
                    throw new IllegalArgumentException("Plugin not passing a map as parameter: " + call.arguments);
                }
                arguments = (Map<String, Object>) call.arguments;
                
                // Extract parameters
                lineColor = (String) arguments.get("lineColor");
                flashIconPath = (String) arguments.get("flashIconPath");
                flashOffIconPath = (String) arguments.get("flashOffIconPath");
                changeCameraIconPath = (String) arguments.get("changeCameraIconPath");
                changeInputIconPath = (String) arguments.get("changeInputIconPath");
                isShowFlashIcon = (boolean) arguments.get("isShowFlashIcon");
                isShowInputIcon = (boolean) arguments.get("isShowInputIcon");
                isOrientationLandscape = (boolean) arguments.get("isOrientationLandscape");
                isNeedLengthCondition = (boolean) arguments.get("isNeedLengthCondition");
                isNeedOnlyDigitCondition = (boolean) arguments.get("isNeedOnlyDigitCondition");
                minimunLengthMinusOne = (String) arguments.get("minimunLengthMinusOne");
                maximunLengthPlusOne = (String) arguments.get("maximunLengthPlusOne");
                iconSize = (String) arguments.get("iconSize");
                fontSize = (String) arguments.get("fontSize");
                duration = (String) arguments.get("duration");
                
                if (lineColor == null || lineColor.isEmpty()) {
                    lineColor = "#DC143C";
                }

                if (arguments.get("scanMode") != null) {
                    if ((int) arguments.get("scanMode") == BarcodeCaptureActivity.SCAN_MODE_ENUM.DEFAULT.ordinal()) {
                        BarcodeCaptureActivity.SCAN_MODE = BarcodeCaptureActivity.SCAN_MODE_ENUM.QR.ordinal();
                    } else {
                        BarcodeCaptureActivity.SCAN_MODE = (int) arguments.get("scanMode");
                    }
                } else {
                    BarcodeCaptureActivity.SCAN_MODE = BarcodeCaptureActivity.SCAN_MODE_ENUM.QR.ordinal();
                }

                isContinuousScan = (boolean) arguments.get("isContinuousScan");

                startBarcodeScannerActivityView(
                    (String) arguments.get("cancelButtonText"), 
                    isContinuousScan, 
                    iconSize, 
                    changeCameraIconPath, 
                    changeInputIconPath, 
                    flashIconPath, 
                    flashOffIconPath, 
                    fontSize, 
                    duration
                );
            } catch (Exception e) {
                Log.e(TAG, "onMethodCall: " + e.getLocalizedMessage());
                result.error("ERROR", e.getMessage(), null);
            }
        } else {
            result.notImplemented();
        }
    }

    private void startBarcodeScannerActivityView(
            String buttonText, 
            boolean isContinuousScan, 
            String iconSize, 
            String changeCameraIconPath, 
            String changeInputIconPath, 
            String flashIconPath, 
            String flashOffIconPath, 
            String fontSize, 
            String duration) {
        try {
            Intent intent = new Intent(activity, BarcodeCaptureActivity.class)
                    .putExtra("cancelButtonText", buttonText)
                    .putExtra("iconSize", iconSize)
                    .putExtra("flashIconPath", flashIconPath)
                    .putExtra("changeCameraIconPath", changeCameraIconPath)
                    .putExtra("changeInputIconPath", changeInputIconPath)
                    .putExtra("flashOffIconPath", flashOffIconPath)
                    .putExtra("fontSize", fontSize)
                    .putExtra("duration", duration);

            if (isContinuousScan) {
                activity.startActivity(intent);
            } else {
                activity.startActivityForResult(intent, RC_BARCODE_CAPTURE);
            }
        } catch (Exception e) {
            Log.e(TAG, "startView: " + e.getLocalizedMessage());
            if (pendingResult != null) {
                pendingResult.error("ERROR", e.getMessage(), null);
            }
        }
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == RC_BARCODE_CAPTURE) {
            if (resultCode == CommonStatusCodes.SUCCESS) {
                if (data != null) {
                    try {
                        Barcode barcode = data.getParcelableExtra(BarcodeCaptureActivity.BarcodeObject);
                        String barcodeResult = barcode.rawValue;
                        if (pendingResult != null) {
                            pendingResult.success(barcodeResult);
                        }
                    } catch (Exception e) {
                        if (pendingResult != null) {
                            pendingResult.success("-1");
                        }
                    }
                } else {
                    if (pendingResult != null) {
                        pendingResult.success("-1");
                    }
                }
                pendingResult = null;
                arguments = null;
                return true;
            } else {
                if (pendingResult != null) {
                    pendingResult.success("-1");
                }
            }
        }
        return false;
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        barcodeStream = eventSink;
    }

    @Override
    public void onCancel(Object o) {
        barcodeStream = null;
    }

    public static void onBarcodeScanReceiver(final Barcode barcode) {
        if (barcode != null && !barcode.displayValue.isEmpty() && barcodeStream != null) {
            activity.runOnUiThread(() -> barcodeStream.success(barcode.rawValue));
        }
    }

    private class LifeCycleObserver implements DefaultLifecycleObserver {
        @Override
        public void onDestroy(@NonNull LifecycleOwner owner) {
            tearDownPlugin();
        }
    }
}