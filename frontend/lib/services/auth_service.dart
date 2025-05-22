import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final Auth0 auth0;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  Credentials? _credentials;
  UserProfile? _userProfile;
  bool _isLoading = false;
  String? _error;

  // Getters
  Credentials? get credentials => _credentials;
  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _credentials != null;

  // Constructor with Auth0 domain and client ID
  AuthService({required String domain, required String clientId}) 
      : auth0 = Auth0(domain, clientId);

  // Login with Auth0
  Future<void> login() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Use Auth0 SDK for login
      final result = await auth0.webAuthentication().login();
      
      _credentials = result;
      _userProfile = result.user;
      
      // Store token in secure storage
      await _secureStorage.write(key: 'auth_token', value: result.accessToken);
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Logout from Auth0
  Future<void> logout() async {
    try {
      _isLoading = true;
      notifyListeners();
      
      // Use Auth0 SDK for logout
      await auth0.webAuthentication().logout();
      
      // Clear local credentials
      _credentials = null;
      _userProfile = null;
      
      // Remove token from secure storage
      await _secureStorage.delete(key: 'auth_token');
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Check if token exists and try to restore session
  Future<bool> checkAuth() async {
    try {
      final storedToken = await _secureStorage.read(key: 'auth_token');
      if (storedToken == null) {
        return false;
      }
      
      // Token exists, but we need to verify it's still valid
      // In a real app, you might want to validate the token with the API
      // For now, we'll just assume it's valid if it exists
      
      _credentials = Credentials(
        accessToken: storedToken,
        idToken: '',  // We don't have the ID token from storage
        expiresAt: DateTime.now().add(const Duration(hours: 1)), // Placeholder
      );
      
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    }
  }

  // Get the access token
  String? getAccessToken() {
    return _credentials?.accessToken;
  }
} 