import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  User? get user => firebaseUser.value;
  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  final errorMessage = "".obs;

  Future<UserCredential?> createUser(String email, String pwd) async {
    UserCredential? credential;
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      )
          .then((value) async {
        print("auth controller created user $value");
        credential = value;
      });
    } on FirebaseAuthException catch (e) {
      String? message = getCreateUserErrorMessage(e);
      errorMessage.value = "$message";
      print("Error $message");
    }
    return credential;
  }

  String? getCreateUserErrorMessage(FirebaseAuthException e) {
    return ({
      'email-already-in-use': 'Account already exists!',
      'invalid-email': 'Invalid email!',
      'operation-not-allowed': 'Could not create account!',
      'weak-password': 'Weak password!',
      'too-many-requests': 'Too many requests! Try again after some time.',
    })[e.code];
  }

  Future<UserCredential?> signInUser(String email, String pwd) async {
    UserCredential? credential;
    try {
      credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pwd,
      );
    } on FirebaseAuthException catch (e) {
      String? message = getSignInErrorMessage(e);
      errorMessage.value = "$message";
      print("Error $message");
      print("Error ${e.code}");
    }
    return credential;
  }

  String? getSignInErrorMessage(FirebaseAuthException e) {
    return ({
      'invalid-email': 'Invalid email!',
      'user-disabled': 'Account was disabled!',
      'user-not-found': 'User not found!',
      'wrong-password': 'Wrong password!',
      'too-many-requests': 'Too many requests! Try again after some time.',
    })[e.code];
  }

  Future<void> signOut() async {
    print("signing out ${user!.uid}");
    try {
      await _auth.signOut();
    } catch (e) {
      String message = "Could not sign you out. Retry after some time.";
      print("Could not sign you out. Retry after some time.");
      displaySnackBar(
        message: message,
      );
    }
  }

  void displaySnackBar({required String message}) {
    print(message);
    Get.snackbar(
      "Error!",
      message,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
