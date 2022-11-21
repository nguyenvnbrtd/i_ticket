import '../core/utils/constants.dart';
import '../core/utils/log_utils.dart';
import '../core/utils/share_pref.dart';
import 'env_config.dart';

enum ENV { dev, staging, production }

extension EnvExtension on ENV {

  Future<bool> switchENV() async {
    try{
      switch(this){
        case ENV.dev:
          await SharePref.put(Constants.ENV_KEY, ENV.dev.name);
          break;
        case ENV.staging:
          await SharePref.put(Constants.ENV_KEY, ENV.staging.name);
          break;
        case ENV.production:
          await SharePref.put(Constants.ENV_KEY, ENV.production.name);
          break;
      }
      return true;
    }catch(e){
      LogUtils.e(functionName: 'switchENV', tag: 'Switch Environment', message: 'Change environment fail', error: e);
      return false;
    }
  }

  static Future<bool> switchTo(ENV env) async {
    LogUtils.i(tag: 'Environment change', message: env.name);
    try{
      await SharePref.put(Constants.ENV_KEY, env.name);
      return true;
    }catch(e){
      LogUtils.e(functionName: 'switchTo', tag: 'Switch Environment', message: env.name);
      return false;
    }
  }

  static Future<ENV> getConfig() async {
    String? name = await SharePref.getSharePref(Constants.ENV_KEY, SharePrefType.STRING);
    // todo change prod
    var env = ENV.dev;
    if (name?.isEmpty ?? true) {
      SharePref.put(Constants.ENV_KEY, env.name);
      return env;
    } else {
      return ENV.values.firstWhere((element) => element.name == name);
    }
  }

  EnvConfig get iTicketService {
    switch (this) {
      case ENV.dev:
        return EnvConfig("https://");
      case ENV.staging:
        return EnvConfig("https://");
      default: // prod
        return EnvConfig("https://");
    }
  }
}
