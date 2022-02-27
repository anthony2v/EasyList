import '../models/user.dart';
import './connected_products.dart';

class UserModel extends ConnectedProducts {
  void login(String email, String password) {
    authenticatedUser =
        User(id: "f13jfi13g4g2g3fwe", email: email, password: password);
  }
}
