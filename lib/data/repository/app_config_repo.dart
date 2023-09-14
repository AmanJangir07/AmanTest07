import 'package:shopiana/data/model/response/app_config.dart';
import 'package:shopiana/helper/api.dart';
import 'package:shopiana/helper/api_base_helper.dart';

class AppConfigRepo {
  ApiBaseHelper _helper = ApiBaseHelper();
  Future<AppConfig?> getAppConfig() async {
    String url = API.GET_INITIAL_CONFIG;
    AppConfig? initialConfig;
    final response = await _helper.get(url: url);
    final extractedData = response as dynamic;
    if (extractedData != null) {
      initialConfig = AppConfig.fromJson(extractedData);
    }
    return initialConfig;
  }
}
