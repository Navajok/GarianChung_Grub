abstract class Profile {
  static AppUser? currentUser;
  static final List<AppUser> _users = [
    AppUser("garian", "garianchung@gmail.com", "123"),
  ];

  static bool register(String name, String email, String password) {
    // prevent duplicate email
    for (final user in _users) {
      if (user.email == email) return false;
    }

    _users.add(AppUser(name, email, password));
    return true;
  }

  static bool login(String email, String password) {
    for (final user in _users) {
      if (user.email == email && user.password == password) {
        currentUser = user;
        return true;
      }
    }
    return false;
  }

  static void logout() {
    currentUser = null;
  }
}

class AppUser {
  String name;
  String email;
  String password;

  AppUser(this.name, this.email, this.password);
}
