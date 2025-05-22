import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/theme.dart';
import 'services/auth_service.dart';
import 'services/api_service.dart';
import 'services/config_service.dart';
import 'config/app_config.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market Tester',
      theme: AppTheme.lightTheme,
      home: FutureBuilder<Map<String, dynamic>>(
        // Get Auth0 configuration
        future: ConfigService().getAuth0Config(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          
          if (snapshot.hasError || !snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading configuration: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Rebuild the app to try again
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const MyApp()),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          
          final auth0Config = snapshot.data!;
          
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => AuthService(
                  domain: auth0Config['domain'] ?? AppConfig.auth0Domain,
                  clientId: auth0Config['clientId'] ?? AppConfig.auth0ClientId,
                ),
              ),
              Provider(create: (_) => ApiService()),
              Provider(create: (_) => ConfigService()),
            ],
            child: Consumer<AuthService>(
              builder: (context, authService, _) {
                // Show landing page for non-authenticated users
                return const LandingPage();
                
                // After they sign up or log in, we can check auth status
                // Uncomment this when ready to implement authentication flow
                /*
                return FutureBuilder<bool>(
                  future: authService.checkAuth(),
                  builder: (context, authSnapshot) {
                    if (authSnapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    
                    final bool isAuthenticated = authSnapshot.data ?? false;
                    
                    if (isAuthenticated) {
                      // User is authenticated, update API service with token
                      final apiService = Provider.of<ApiService>(context, listen: false);
                      final token = authService.getAccessToken();
                      
                      if (token != null) {
                        apiService.setAuthToken(token);
                      }
                      
                      return const HomeScreen();
                    } else {
                      return const LoginScreen();
                    }
                  },
                );
                */
              },
            ),
          );
        },
      ),
    );
  }
}
