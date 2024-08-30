package global_corporation.general_developer.device_application_flutter;

import java.util.List;
import java.util.Map;

public interface InstalledAppsCallback {

    void onInstalledAppsListAvailable(List<Map<String, Object>> apps);

}
