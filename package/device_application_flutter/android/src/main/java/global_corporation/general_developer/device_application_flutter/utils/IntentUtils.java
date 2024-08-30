package global_corporation.general_developer.device_application_flutter.utils;

import android.content.Context;
import android.content.Intent;

public class IntentUtils {

    public static boolean isIntentOpenable(Intent intent, Context context) {
        if (intent == null || context == null) {
            return false;
        } else {
            return context.getPackageManager().queryIntentActivities(intent, 0).size() > 0;
        }
    }

}
