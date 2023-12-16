import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themanager/common/helper/db_helper.dart';
import 'package:themanager/common/widgets/show_dialogue.dart';

import '../../../common/routes/routes.dart';

final AuthRepositoryProvider = Provider((ref) {
  return AuthRepository(auth: FirebaseAuth.instance);
});

class AuthRepository {
  final FirebaseAuth auth;
  AuthRepository({required this.auth});
  void verifyOtp({
    required context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);

      await auth.signInWithCredential(credential);
      if (!mounted) {
        return;
      }
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    } on FirebaseAuth catch (e) {
      showAlertDialogue(context: context, message: e.toString());
    }
  }

// void sendOtp({required BuildContext context, required String phone}) async {
//   try {
//     await auth.verifyPhoneNumber(
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         try {
//           await auth.signInWithCredential(credential);
//         } catch (e) {
//           showAlertDialogue(context: context, message: e.toString());
//         }
//       },
//       verificationFailed: (e) async {
//         await showAlertDialogue(context: context, message: e.toString());
//       },
//       codeSent: (smsCodeId, resendCodeId) {
//         DBHelper.createUser(1);
//         Navigator.pushNamed(context, Routes.otp,
//             arguments: {"phone": phone, "smsCodeId": smsCodeId});
//       },
//       codeAutoRetrievalTimeout: (String smscodeId) {
//         // This callback can be left empty if not used.
//       },
//     );
//   } on FirebaseAuthException catch (e) {
//     showAlertDialogue(context: context, message: e.toString());
//   }
// }


void sendOtp({required BuildContext context, required String phone}) async {
  try {
    await auth.verifyPhoneNumber(
      phoneNumber: phone, // Provide the phone number here
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await auth.signInWithCredential(credential);
        } catch (e) {
          showAlertDialogue(context: context, message: e.toString());
        }
      },
      verificationFailed: (e) async {
        await showAlertDialogue(context: context, message: e.toString());
      },
      codeSent: (smsCodeId, resendCodeId) {
        DBHelper.createUser(1);
        Navigator.pushNamed(context, Routes.otp,
            arguments: {"phone": phone, "smsCodeId": smsCodeId});
      },
      codeAutoRetrievalTimeout: (String smscodeId) {
        // This callback can be left empty if not used.
      },
    );
  } on FirebaseAuthException catch (e) {
    showAlertDialogue(context: context, message: e.toString());
  }
}

}
