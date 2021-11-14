/*
after getting the user data from DB
we keep only the required attributes in
our result
*/
class UserData {
  final String? uid;
  final String? displayName;
  final String? email;
  UserData({
    this.uid,
    this.displayName,
    this.email,
  });
}
