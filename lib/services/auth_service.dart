class AuthService {
  // Mock login function
  static Future<bool> login(String username, String password) async {
    // Simulate network delay for realism
    await Future.delayed(const Duration(seconds: 1));
    
    // Accept any non-empty credentials for the hackathon demo
    if (username.isNotEmpty && password.isNotEmpty) {
      return true;
    }
    return false;
  }
}