import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mappp/bloc/bloc_state.dart';
import 'package:mappp/constants/my_colors.dart';
import 'package:mappp/layout/screen/login_screen.dart';
import 'package:mappp/models/strings.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verificationId;

  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+966$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print('verificationFailed : ${error.toString()}');
    emit(ErrorOccurred(errorMsg: error.toString()));
    print('=======================');
    print(error);
    print('=======================');
  }

  void codeSent(String verificationId, int? resendToken) {
    print('codeSent');
    this.verificationId = verificationId;
    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(verificationId: this.verificationId, smsCode: otpCode);

    await signIn(credential);
    emit(PhoneNumberSubmited());
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      emit(PhoneOTPVerified());
    } catch (error) {
      print('=======================');
      print(error);
      print('=======================');

      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

  Future<void> logOut(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      navigateTo(context, LoginScreen());
      Fluttertoast.showToast(
        msg: 'Logout successful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        // timeInSecForIosWeb: 1,
        backgroundColor: MyColors.blue,

        textColor: MyColors.lightGrey,
        fontSize: 16.0,
      );
      emit(LogoutSuccessful());
    } catch (e) {
      print(e);
    }
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }
}
