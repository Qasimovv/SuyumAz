import 'package:local_auth/local_auth.dart';

class LocalAuthHelper {
  LocalAuthHelper._();
  static LocalAuthHelper _instance = LocalAuthHelper._();
  factory LocalAuthHelper()=>_instance;
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<BiometricType> supportedBiometric() async {
    try {
      List<BiometricType> supportedBiometrics =
          await _localAuth.getAvailableBiometrics();
      if (supportedBiometrics == null || supportedBiometrics.isEmpty)
        return null;
      print("all");
      print(supportedBiometrics);
      if (supportedBiometrics.contains(BiometricType.fingerprint))
        return BiometricType.fingerprint;
      if (supportedBiometrics.contains(BiometricType.face))
        return BiometricType.face;
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> authenticate([String reason]) async{
    return await _localAuth.authenticateWithBiometrics(
        localizedReason: reason ?? ("App needs face ID"),
        stickyAuth: true,
        sensitiveTransaction: false);
  }
}
