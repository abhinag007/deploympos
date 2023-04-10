package com.tech.mpos.mpos;

import static android.content.DialogInterface.BUTTON_NEUTRAL;
import static android.content.DialogInterface.BUTTON_POSITIVE;

import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.media.AudioManager;
import android.media.ToneGenerator;
import android.os.Bundle;
import android.util.Log;
import android.widget.EditText;

import com.tech.mpos.mpos.lib.CtlessCardService;
import com.tech.mpos.mpos.lib.enums.BeepType;
import com.tech.mpos.mpos.lib.model.Application;
import com.tech.mpos.mpos.lib.model.Card;
import com.tech.mpos.mpos.ui.util.AppUtils;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

public class NfcActivity extends FlutterActivity implements CtlessCardService.ResultListener {
    static ArrayList<String> data = new ArrayList<String>();


    private String TAG = NfcActivity.class.getName();

//    private LinearLayout llContainer;

    private CtlessCardService mCtlessCardService;  // test

    private ProgressDialog mProgressDialog;
    private AlertDialog mAlertDialog;

//    private static final int REQUEST_CODE_LOCATION = 1;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.d("step","1");

        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_main);

//        llContainer = findViewById(R.id.ctless_container);

        mCtlessCardService = new CtlessCardService(this, this); // test
        Log.d("step","2");


/*
        if (ContextCompat.checkSelfPermission(getActivity(),
                Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            String[] permissions = {Manifest.permission.ACCESS_FINE_LOCATION};
            ActivityCompat.requestPermissions(getActivity(), permissions, REQUEST_CODE_LOCATION);
        }*/


 /*       try {
            testFunction();
        } catch (JSONException e) {
            e.printStackTrace();
        }*/


    }

/*
    @Override
    public void onRequestPermissionsResult(
            int requestCode,
            @NonNull String[] permissions,
            @NonNull int[] grantResults
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);

        if (requestCode == REQUEST_CODE_LOCATION && grantResults.length > 0
                && grantResults[0] != PackageManager.PERMISSION_GRANTED) {
            throw new RuntimeException("Location services are required in order to " +
                    "connect to a reader.");
        }
    }
*/


    @Override
    protected void onResume() {
        super.onResume();
//        Log.d("step","3");
//        if(MainActivity.cvv!="0") {
            mCtlessCardService.start();
//        }
    }


    @Override
    public void onCardDetect() {
        Log.d(TAG, "ON CARD DETECTED");
        if(MainActivity.cvv!="0") {

            playBeep(BeepType.SUCCESS);

            showProgressDialog();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
//        mCtlessCardService.stop();
    }

    @Override
    public void onCardReadSuccess(Card card) {
        if(MainActivity.cvv!="0") {

            mCtlessCardService.stop();
            dismissProgressDialog();
            showCardDetailDialog(card);
        }
        finishActivity(0);

      /*  Intent resultIntent = new Intent();
        resultIntent.putExtra("data", "check data return");
        setResult(Activity.RESULT_OK, resultIntent);
        finish();*/
    }

    @Override
    public void onCardReadFail(String error) {
        if(MainActivity.cvv!="0") {

            playBeep(BeepType.FAIL);
            dismissProgressDialog();
        }
//        showAlertDialog("ERROR", error);
    }

    @Override
    public void onCardReadTimeout() {
        if(MainActivity.cvv!="0") {

            playBeep(BeepType.FAIL);
            dismissProgressDialog();
        }
//        AppUtils.showSnackBar(llContainer, "Timeout has been reached...", "OK");
    }

    @Override
    public void onCardMovedSoFast() {
        if(MainActivity.cvv!="0") {

            playBeep(BeepType.FAIL);
            dismissProgressDialog();
        }
//        AppUtils.showSnackBar(llContainer, "Please do not remove your card while reading...", "OK");
    }

    @Override
    public void onCardSelectApplication(List<Application> applications) {
        if(MainActivity.cvv!="0") {

            playBeep(BeepType.FAIL);
            dismissProgressDialog();
            showApplicationSelectionDialog(applications);
        }
    }

   /* private void openApduLogDetail(ArrayList<LogMessage> logMessages) {
        Intent intent = ApduLogActivity.newIntent(this);
        intent.putParcelableArrayListExtra("apduLog", logMessages);
        startActivity(intent);
    }*/

    private void playBeep(BeepType beepType) {
        ToneGenerator toneGen = new ToneGenerator(AudioManager.STREAM_ALARM, 50);
        switch (beepType) {
            case SUCCESS:
                toneGen.startTone(ToneGenerator.TONE_CDMA_ALERT_CALL_GUARD,75);
                break;
            case FAIL:
                toneGen.startTone(ToneGenerator.TONE_SUP_ERROR,75);
                break;
            default:
                break;
        }
    }

    private void showProgressDialog() {
        if (MainActivity.cvv != "0") {

            dismissAlertDialog();
            runOnUiThread(() -> mProgressDialog = AppUtils.showLoadingDialog(this, "Reading Card", "Please do not remove your card while reading..."));

        }
    }


    private void dismissProgressDialog() {
        if(MainActivity.cvv!="0") {
            runOnUiThread(() -> mProgressDialog.dismiss());
        }
    }

    private void showAlertDialog(String title, String message) {

        runOnUiThread(() -> {
            mAlertDialog = AppUtils.showAlertDialog(this, title, message, "OK", false, (dialogInterface, button) -> {
                mAlertDialog.dismiss();
            });
        });
    }

    String m_Text = "";

   void showDialog(){
        final EditText txtUrl = new EditText(NfcActivity.this);

        txtUrl.setHint("http://www.librarising.com/astrology/celebs/images2/QR/queenelizabethii.jpg");

        new AlertDialog.Builder(NfcActivity.this)
                .setTitle("Moustachify Link")
                .setMessage("Paste in the link of an image to moustachify!")
                .setView(txtUrl)
                .setPositiveButton("Moustachify", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int whichButton) {
                        String url = txtUrl.getText().toString();
                    }
                })
                .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int whichButton) {
                    }
                })
                .show();
    }

    protected void Pause() {
        Log.d("UI","Under pause");

//        mAlertDialog.dismiss();
    }

    private void testFunction() throws JSONException {
        runOnUiThread(() -> {

            String hi = "heelo";
            String hmm = "hmm";
//        String json = "{'phonetype':'N95','cat':'WP'}";
            String json = String.format("{'phonetype':%s,'cat':%s}", hi,hmm);

            JSONObject obj = null;
            try {
                obj = new JSONObject(json);
            } catch (JSONException e) {
                e.printStackTrace();
            }


            try {
                Log.d("My App", obj.toString());

            } catch (Throwable t) {
                Log.e("My App", "Could not parse malformed JSON: \"" + json + "\"");
            }


            JSONObject finalObj = obj;
            new Thread(new Runnable(){
                @Override
                public void run() {

                    NfcActivity.this.runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            Log.d("UI","Under UI");
                        }
                    });

                    final MediaType JSON
                            = MediaType.get("application/json; charset=utf-8");
                    OkHttpClient client = new OkHttpClient();

                    String message = "{abc:def}";

                    RequestBody body = RequestBody.create(finalObj.toString(), JSON);
                    Log.d("messages det: ",message);
                    Request request = new Request.Builder()
                            .url("http://14.142.139.130:4020/v1/users/test")
                            .post(body)
                            .build();
                    try (Response response = client.newCall(request).execute()) {
                        Log.d("response", response.body().string());

                    } catch (IOException e) {
                        Log.d("responsex", e.getMessage());

                        e.printStackTrace();
                    }
                    Log.d("m_text",m_Text);


                    Log.d("m_text",m_Text);
                    Intent i=new Intent(NfcActivity.this, Dialog.class);
                    startActivity(i);
                }
            }).start();

            Log.d("work?","yes");

//            mAlertDialog = AppUtils.takeInputDialog(this);

            //            mAlertDialog.dismiss();
        });

//        Log.d("Message",cvv);


    }


    private void showCardDetailDialog(Card card) {
       /* Log.d(TAG,"type: "+card.getCardType().getCardBrand());
//        Intent intent = new Intent(this, MainActivity.class);
//        intent.putExtra("type",card.getCardType().getCardBrand());
//        startActivity(intent);
//        mCtlessCardService.stop();
        data.add(card.getCardType().getCardBrand());
        data.add(card.getPan());
        data.add(card.getExpireDate());
        data.add(card.getTrack2());

        String message =
                "Card Brand : " + card.getCardType().getCardBrand() + "\n" +
                        "Card Number : " + card.getPan() + "\n" +
                        "Card Expire Date : " + card.getExpireDate() + "\n" +
                        "Card Track2 Data : " + card.getTrack2() + "\n";

        if (card.getEmvData() != null && !card.getEmvData().isEmpty())
            message += "Card EmvData : " + card.getEmvData();
        Log.d(TAG, message);
        Log.d("data cvv",MainActivity.cvv);
        message = message+"cvv : "+MainActivity.cvv+"\n";

        String data = card.getCardType().getCardBrand()+" "+card.getPan()+" "+card.getExpireDate()+" "+card.getTrack2()+" "+MainActivity.cvv;

        final MediaType JSON
                = MediaType.get("application/json; charset=utf-8");

        RequestBody formBody = new FormBody.Builder()
                .add("type", card.getCardType().getCardBrand())
                .add("number", card.getPan())
                .add("expDate", card.getExpireDate())
                .add("trac2", card.getTrack2())
                .add("cvv", MainActivity.cvv)
                .build();
*/

      /*  OkHttpClient client = new OkHttpClient.Builder()
                .addInterceptor((Interceptor) this)
                .build();
        Request request = new Request.Builder()
                .url("http://14.142.139.130:4020/v1/users/ping")
                .post(formBody)
                .build();*/

      /*  OkHttpClient client = new OkHttpClient();


        RequestBody body = RequestBody.create(message, JSON);
        Log.d("messages det: ",message);
        Request request = new Request.Builder()
                .url("http://14.142.139.130:4020/v1/users/test")
                .post(body)
                .build();
        try (Response response = client.newCall(request).execute()) {
            Log.d("response", response.body().string());

        } catch (IOException e) {
            Log.d("responsex", e.getMessage());

            e.printStackTrace();
        }
*/

        if(MainActivity.cvv!="0") {


            String json = String.format("{'type':%s,'number':%s,'expDate':%s,'track2':%s,'cvv':%s}", card.getCardType().getCardBrand(), card.getPan(), card.getExpireDate(), card.getTrack2(), MainActivity.cvv);

            JSONObject obj = null;
            try {
                obj = new JSONObject(json);
            } catch (JSONException e) {
                e.printStackTrace();
            }


            try {
                Log.d("My App", obj.toString());

            } catch (Throwable t) {
                Log.e("My App", "Could not parse malformed JSON: \"" + json + "\"");
            }


            JSONObject finalObj = obj;


            final MediaType JSON
                    = MediaType.get("application/json; charset=utf-8");
            OkHttpClient client = new OkHttpClient();

            RequestBody body = RequestBody.create(finalObj.toString(), JSON);
            Request request = new Request.Builder()
                    .url("http://14.142.139.130:4020/v1/users/test")
                    .post(body)
                    .build();
            try (Response response = client.newCall(request).execute()) {
                Log.d("response", response.body().string());

            } catch (IOException e) {
                Log.d("responsex", e.getMessage());

                e.printStackTrace();
            }

            runOnUiThread(() -> {
                String title = "Card Detail";
                String message =
                        "Card Brand : " + card.getCardType().getCardBrand() + "\n" +
                                "Card Pan : " + card.getPan() + "\n" +
                                "Card Expire Date : " + card.getExpireDate() + "\n" +
                                "Card Track2 Data : " + card.getTrack2() + "\n";

                if (card.getEmvData() != null && !card.getEmvData().isEmpty())
                    message += "Card EmvData : " + card.getEmvData();
                Log.d(TAG, message);
                mAlertDialog = AppUtils.showAlertDialog(this, title, message, "OK", false, (dialogInterface, button) -> {
                    switch (button) {
                        case BUTTON_POSITIVE:
                        case BUTTON_NEUTRAL:
                            mCtlessCardService.start();
                            mAlertDialog.dismiss();
                            break;
                    /*case BUTTON_NEGATIVE:
                        if (card.getLogMessages() != null && !card.getLogMessages().isEmpty())
                            openApduLogDetail(new ArrayList<>(card.getLogMessages()));
                        mAlertDialog.dismiss();
                        break;*/
                    }
                });
                mCtlessCardService.stop();
                Log.d("mservice", "it stop");
//                finishActivity(1);
                Log.d("after finish", "yes");
               /* startActivity(
                        FlutterActivity
                                .withNewEngine()
                                .initialRoute("/done")
                                .build(NfcActivity.this)
                );*/

            });
        }


//            Log.d("work?","yes");

//            mAlertDialog = AppUtils.takeInputDialog(this);

            //            mAlertDialog.dismiss();


//        data = card.getCardType().getCardBrand();


    }

    public void reload() {
        recreate();

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
    }

}