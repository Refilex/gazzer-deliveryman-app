import 'package:gazzer_delivery/feature/profile/domain/models/profile_model.dart';

abstract class ForgotPasswordServiceInterface {
  Future<dynamic> changePassword(ProfileModel userInfoModel, String password);

  Future<dynamic> forgotPassword(String? phone);

  Future<dynamic> resetPassword(String? resetToken, String phone,
      String password, String confirmPassword);

  Future<dynamic> verifyToken(String? phone, String token);
}
