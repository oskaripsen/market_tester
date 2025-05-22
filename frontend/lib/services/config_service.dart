import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class ConfigService {
  final String baseUrl;
  
  ConfigService({String? baseUrl}) : baseUrl = baseUrl ?? AppConfig.apiBaseUrl;
  
  // Get Auth0 configuration from backend
  Future<Map<String, dynamic>> getAuth0Config() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/auth/config'),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load Auth0 configuration: ${response.statusCode}');
      }
    } catch (e) {
      // If the backend is not available, use the local configuration
      return {
        'domain': AppConfig.auth0Domain,
        'clientId': AppConfig.auth0ClientId,
        'audience': AppConfig.auth0Audience,
      };
    }
  }
} 