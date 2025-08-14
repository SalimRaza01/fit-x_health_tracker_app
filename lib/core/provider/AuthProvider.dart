import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_x/core/constants/GlobalMethods.dart';
import 'package:fit_x/core/data/models/UserModel.dart';
import 'package:fit_x/core/services/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:fit_x/core/constants/Constants.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  bool _isLoading = false;
  bool _isSuccessful = false;
  String? _uid;
  String? _phoneNumber;
  UserModel? _userModel;

  bool get isLoading => _isLoading;
  bool get isSuccessful => _isSuccessful;
  String? get uid => _uid;
  String? get phoneNumber => _phoneNumber;
  UserModel? get userModel => _userModel;

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _verificationId;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> logOut() async {
    await _auth.signOut();

    notifyListeners();
  }

  // ─────────────────────────────────────────────────────
  // Future<bool> checkUserExists() async {
  //   DocumentSnapshot documentSnapshot = await _firestore.collection(Constants.users).doc(_uid).get();
  //   return documentSnapshot.exists;
  // }


  //Check Authentication State

  Future<bool> checkAuthenticationState() async {
    await Future.delayed(const Duration(seconds: 2));

    if (_auth.currentUser != null) {
      _uid = _auth.currentUser!.uid;
      // await getUserDataFromFirestore();

      if (_userModel != null) {
        await saveUserDataToSharedPreferences();
        notifyListeners();
        return true;
      } else {
        print("⚠️ Authenticated user has no Firestore data.");
        return false;
      }
    }
    return false;
  }

  // ─────────────────────────────────────────────────────
  Future<void> saveUserDataToSharedPreferences() async {
    if (_userModel != null) {
      await SharedPrefsService.instance.setString(
        Constants.userModel,
        jsonEncode(_userModel!.toMap()),
      );
    } else {
      print("⚠️ Tried to save null userModel to SharedPreferences");
    }
  }

  // ─────────────────────────────────────────────────────
  Future<void> getDataFromSharedPreferences() async {
    final userModelString = await SharedPrefsService.instance.getString(Constants.userModel) ?? "";
    if (userModelString.isNotEmpty) {
      _userModel = UserModel.fromMap(jsonDecode(userModelString));
      _uid = _userModel!.uid;
      notifyListeners();
    }
  }

  // ─────────────────────────────────────────────────────


  // Future<void> getUserDataFromFirestore() async {
  //   try {
  //     final documentSnapshot = await _firestore.collection(Constants.users).doc(_uid).get();

  //     final data = documentSnapshot.data();
  //     if (data != null) {
  //       _userModel = UserModel.fromMap(data);
  //     } else {
  //       _userModel = null;
  //       print("⚠️ No user data found for UID $_uid");
  //     }

  //     notifyListeners();
  //   } catch (e) {
  //     print("🔥 Error fetching user data: $e");
  //     _userModel = null;
  //   }
  // }

  // 📱 Sign In with Phone Number
  Future<void> signInWithPhoneNumber({
    required String phoneNumber,
    required BuildContext context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          final value = await _auth.signInWithCredential(credential);
          _uid = value.user!.uid;
          _phoneNumber = value.user!.phoneNumber;
          _isSuccessful = true;
          _isLoading = false;
          notifyListeners();
        },
        verificationFailed: (FirebaseAuthException e) {
          _isSuccessful = false;
          _isLoading = false;
          notifyListeners();
          showSnackBar(context, e.message ?? 'Phone verification failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          _isLoading = false;
          notifyListeners();
          context.push(
            '${Constants.OtpScreen}?vid=$verificationId&phone=$phoneNumber',
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }


  // Send OTP
  Future<void> sendOtp({
    required String phoneNumber,
    required VoidCallback onCodeSent,
    required Function(String error) onError,
  }) async {
    _setLoading(true);
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            await _auth.signInWithCredential(credential);
            notifyListeners();
          } on FirebaseAuthException catch (e) {
            onError(_parseFirebaseAuthException(e));
          } catch (e) {
            onError('Auto-login failed: $e');
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          onError(_parseFirebaseAuthException(e));
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          onCodeSent();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
        timeout: const Duration(seconds: 60),
      );
    } on FirebaseAuthException catch (e) {
      onError(_parseFirebaseAuthException(e));
    } catch (e) {
      onError('Unexpected error: $e');
    } finally {
      _setLoading(false);
    }
  }

// Verify OTP
  Future<void> verifyOtp({
    required String smsCode,
    required VoidCallback onSuccess,
    required Function(String error) onError,
  }) async {
    _setLoading(true);
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      onError(_parseFirebaseAuthException(e));
    } catch (e) {
      onError('Verification failed: $e');
    } finally {
      _setLoading(false);
    }
  }

// Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      logger.e("Logout FirebaseAuth error: ${e.code} - ${e.message}");
    } on FirebaseException catch (e) {
      logger.e("Logout Firebase error: ${e.code} - ${e.message}");
    } catch (e) {
      logger.e("Logout unknown error: $e");
    }
  }

  String _parseFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'The phone number entered is invalid.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-verification-code':
        return 'The OTP entered is incorrect.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid. Please request OTP again.';
      case 'session-expired':
        return 'OTP session has expired. Please resend OTP.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection.';
      default:
        return e.message ?? 'Authentication error occurred.';
    }
  }



}
