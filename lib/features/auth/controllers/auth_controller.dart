import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRespository = ref.watch(AuthRepositoryProvider);
  return AuthController(authRepository: authRespository);
});

class AuthController {
  final AuthRepository authRepository;
  AuthController({required this.authRepository});
  void verifyOtp({
    required context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) {
    authRepository.verifyOtp(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: mounted);
  }

  void sendSms({required BuildContext context, required String phonenumber}) {
    authRepository.sendOtp(context: context, phone: phonenumber);
  }
}
