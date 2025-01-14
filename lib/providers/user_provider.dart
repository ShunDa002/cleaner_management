import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domains/user_domain.dart';

class UserProvider extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _firebaseUser = Rx<User?>(null);

  Rx<UserDomain> userDomain = UserDomain(id: '', email: '', role: '').obs;

  UserDomain get userLogin => userDomain.value;

  set userLogin(UserDomain value) => userDomain.value = value;

  void clear() {
    userDomain.value = UserDomain(id: '', email: '', role: '');
  }

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  String? get user => _firebaseUser.value?.email;

  @override
  void onInit() async {
    super.onInit();

    // Bind the FirebaseAuth user stream
    _firebaseUser.bindStream(_auth.authStateChanges());

    // Check if a user is already signed in
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      try {
        // Fetch user details from Firestore
        UserDomain user = await getUser(currentUser.uid);

        // Update the user domain with the current user's details
        userDomain.value = user;
      } catch (e) {
        // Handle any error, such as missing user data in Firestore
        print("Error fetching user on app start: $e");
        clear();
      }
    } else {
      // Clear user data if no user is logged in
      clear();
    }
  }

// Create in Firestore Authentication
  void createUser(String email, String password, String role) async {
    try {
      // Optionally set locale for Firebase
      _auth.setLanguageCode('en'); // Adjust locale if needed
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Create a user in Firestore
      UserDomain user = UserDomain(
        id: authResult.user?.uid ?? '',
        email: email,
        role: role ?? 'owner',
      );
      if (await createNewUser(user)) {
        // User created successfully
        Get.find<UserProvider>().userLogin = user;
        Get.back();
      }
    } catch (e) {
      Get.snackbar("Error creating account", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

// Store in Firestore Database
  Future<bool> createNewUser(UserDomain user) async {
    try {
      await usersCollection.doc(user.id).set({
        'email': user.email,
        'role': user.role,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

// Get current user from Firestore db
  Future<UserDomain> getUser(String id) async {
    try {
      // Fetch the user document from Firestore
      final user = await usersCollection.doc(id).get();

      // Validate the document
      if (!user.exists || user.data() == null) {
        throw Exception(
            "User document does not exist or contains no data. $id");
      }

      // Return the user domain
      return UserDomain.fromDocumentSnapshot(user);
    } catch (e) {
      print("Error fetching user: $e");
      rethrow; // Propagate the exception for further handling
    }
  }

// Login with Firestore Authentication
  void login(String email, String password) async {
    try {
      // Attempt to sign in the user
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // Ensure the user ID is valid
      if (authResult.user?.uid == null) {
        throw Exception("Failed to retrieve user ID after login.");
      }

      // Fetch user details from Firestore
      UserDomain user = await getUser(authResult.user!.uid);
      print(authResult.user);

      // Update the user domain in the provider
      Get.find<UserProvider>().userLogin = user;
    } catch (e) {
      // Display error to the user
      Get.snackbar("Error logging in", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

// Logout with Firestore Authentication
  void signOut() async {
    try {
      await _auth.signOut();
      Get.find<UserProvider>().clear();
    } catch (e) {
      Get.snackbar("Error signing out", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
