package com.tech.mpos.mpos;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {

//    private static final String CHANNEL = "com.nfc.transaction/method";
    private String TAG = MainActivity.class.getName();
    static String cvv = "0";
    static int initial = 0;


    @Override
    protected void onStart() {
        super.onStart();
//        startNfcService();
    }

  /*  @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

        Log.d("start","under");

        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("startNfcService")) {
                                Log.d("start","under configFlutterEngine");
                                Log.d("Main CVV",cvv);
//                                startNfcService();
                                Log.d("step","6");
                                result.success(0);

                            } else if(call.method.equals("changeNfcService")) {
                                cvv = call.argument("text");
                                Log.d("CVV",cvv);

//                                startNfcService();
//                                stopNfcService();
                                result.success(0);

                            }
                            else {
                                Log.d("step","7");
                                result.notImplemented();
                            }
                        }
                );
    }
*/

    private void stopNfcService() {
        finish();
    }

    private int startNfcService() {

        Log.d("start","it works");
//        System.out.println("Data: "+NfcActivity.data);
        Intent intent = new Intent(this, NfcActivity.class);
        Log.d("step","4");
        Log.d("start","before start");
        startActivity(intent);
        finish();
        Log.d("step","5");
        Log.d("start","after start");


//        getActivity().finish();
        /*if(NfcActivity.data !="") {
            System.out.println("Data: " + NfcActivity.data);
            finish();
        }*/
        return -1;
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK) {
            String returnValue = data.getStringExtra("data");
            Log.d("Check", "act res: "+returnValue);
        }
    }


}

  /*  private static final String CHANNEL = "com.nfc.transaction/method";


    private String TAG = com.nfc.scan.mfccardscan.MainActivity.class.getName();*/

/*    private LinearLayout llContainer;

    private CtlessCardService mCtlessCardService;

    private ProgressDialog mProgressDialog;
    private AlertDialog mAlertDialog;
*/
/*
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if(call.method.equals("startNfcService")) {
                                Intent i = new Intent(this, NfcActivity.class);
                                startActivity(i);
                            }
                            String value = null;
                            Bundle extras = getIntent().getExtras();
                            if (extras != null) {
                                value = extras.getString("type");
                                Log.d(TAG, value);
                            }
//                            return value;


                        }
                );
    }*/



  /*  @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);*/
//        setContentView(R.layout.activity_main);

//        llContainer = findViewById(R.id.ctless_container);

//        mCtlessCardService = new CtlessCardService(this, this);

//        private static final String CHANNEL = "com.nfc.transaction/method";

      /*  GeneratedPluginRegistrant.registerWith(this);
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                        if (call.method.equals("startNfcService")) {
                            Intent intent = new Intent(this, NfcActivity.class);
                            startActivity(intent);
                        }
                    }
                });*/
//    }
        /*
        @Override
        protected void onCreate (Bundle savedInstanceState){
            super.onCreate(savedInstanceState);



        }*/


    /* @Override
    protected void onResume() {
        super.onResume();
        mCtlessCardService.start();
    }

    @Override
    public void onCardDetect() {
        Log.d(TAG, "ON CARD DETECTED");
        playBeep(BeepType.SUCCESS);
        showProgressDialog();
    }

    @Override
    public void onCardReadSuccess(Card card) {
        dismissProgressDialog();
        showCardDetailDialog(card);
    }

    @Override
    public void onCardReadFail(String error) {
        playBeep(BeepType.FAIL);
        dismissProgressDialog();
        showAlertDialog("ERROR", error);
    }

    @Override
    public void onCardReadTimeout() {
        playBeep(BeepType.FAIL);
        dismissProgressDialog();
        AppUtils.showSnackBar(llContainer, "Timeout has been reached...", "OK");
    }

    @Override
    public void onCardMovedSoFast() {
        playBeep(BeepType.FAIL);
        dismissProgressDialog();
        AppUtils.showSnackBar(llContainer, "Please do not remove your card while reading...", "OK");
    }

    @Override
    public void onCardSelectApplication(List<Application> applications) {
        playBeep(BeepType.FAIL);
        dismissProgressDialog();
        showApplicationSelectionDialog(applications);
    }

    private void openApduLogDetail(ArrayList<LogMessage> logMessages) {
        Intent intent = ApduLogActivity.newIntent(this);
        intent.putParcelableArrayListExtra("apduLog", logMessages);
        startActivity(intent);
    }

    private void playBeep(BeepType beepType) {
        ToneGenerator toneGen = new ToneGenerator(AudioManager.STREAM_ALARM, 25);
        switch (beepType) {
            case SUCCESS:
                toneGen.startTone(ToneGenerator.TONE_CDMA_ALERT_CALL_GUARD,50);
                break;
            case FAIL:
                toneGen.startTone(ToneGenerator.TONE_SUP_ERROR,50);
                break;
            default:
                break;
        }
    }

    private void showProgressDialog() {
        dismissAlertDialog();
        runOnUiThread(()-> mProgressDialog = AppUtils.showLoadingDialog(this, "Reading Card", "Please do not remove your card while reading..."));
    }

    private void dismissProgressDialog() {
        runOnUiThread(() -> mProgressDialog.dismiss());
    }

    private void showAlertDialog(String title, String message) {

        runOnUiThread(() -> {
            mAlertDialog = AppUtils.showAlertDialog(this, title, message, "OK", "SHOW APDU LOGS", false, (dialogInterface, button) -> {
                mAlertDialog.dismiss();
            });
        });
    }

    private void showCardDetailDialog(Card card) {

        runOnUiThread(() -> {
            String title = "Card Detail";
            String message =
                    "Card Brand : " + card.getCardType().getCardBrand() + "\n" +
                            "Card Pan : " + card.getPan() + "\n" +
                            "Card Expire Date : " + card.getExpireDate() + "\n" +
                            "Card Track2 Data : " + card.getTrack2() + "\n";

            if(card.getEmvData() != null && !card.getEmvData().isEmpty())
                message += "Card EmvData : " + card.getEmvData();
            Log.d(TAG,message);

            mAlertDialog = AppUtils.showAlertDialog(this, title, message, "OK", "SHOW APDU LOGS", false, (dialogInterface, button) -> {
                switch (button) {
                    case BUTTON_POSITIVE:
                    case BUTTON_NEUTRAL:
                        mCtlessCardService.start();
                        mAlertDialog.dismiss();
                        break;
                    case BUTTON_NEGATIVE:
                        if(card.getLogMessages() != null && !card.getLogMessages().isEmpty())
                            openApduLogDetail(new ArrayList<>(card.getLogMessages()));
                        mAlertDialog.dismiss();
                        break;
                }
            });
        });
    }

    private void showApplicationSelectionDialog(List<Application> applications) {

        String[] appNames = new String[applications.size()];
        int index = 0;
        for (Application application : applications) {
            appNames[index] = application.getAppLabel();
            index++;
        }

        runOnUiThread(() -> {
            String title = "Select One of Your Cards";
            mAlertDialog = AppUtils.showSingleChoiceListDialog(this, title, appNames, "OK", (dialogInterface, i) -> mCtlessCardService.setSelectedApplication(i));
        });
    }

    private void dismissAlertDialog() {
        if(mAlertDialog != null)
            runOnUiThread(() -> mAlertDialog.dismiss());
    }*/
