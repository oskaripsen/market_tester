import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/dimens.dart';
import '../theme/typography.dart';
import '../widgets/responsive_layout.dart';
import 'login_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header/Navigation bar
            _buildNavBar(context),
            
            // Hero section
            _buildHeroSection(context),
            
            // Features section would go here
            
            // Pricing section would go here
            
            // Footer would go here
          ],
        ),
      ),
    );
  }

  Widget _buildNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.spacing32,
        vertical: AppDimens.spacing16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Icon(Icons.analytics, color: AppColors.primary, size: AppDimens.iconLarge),
              const SizedBox(width: AppDimens.spacing8),
              Text(
                'MarketTester',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          
          // Menu items - hide on mobile
          ResponsiveLayout(
            mobile: Container(),
            tablet: _buildMenuItems(),
            desktop: _buildMenuItems(),
          ),
          
          // Auth buttons
          Row(
            children: [
              TextButton(
                onPressed: () {
                  // Navigate to login screen
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const LoginScreen())
                  );
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.spacing8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.spacing24,
                    vertical: AppDimens.spacing12,
                  ),
                ),
                onPressed: () {
                  // Navigate to sign up screen (using login screen for now)
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const LoginScreen())
                  );
                },
                child: const Text('Get Started'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Features',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: AppDimens.spacing24),
        TextButton(
          onPressed: () {},
          child: Text(
            'Pricing',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: AppDimens.spacing24),
        TextButton(
          onPressed: () {},
          child: Text(
            'About',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.spacing32,
        vertical: AppDimens.spacing64,
      ),
      child: ResponsiveLayout(
        mobile: _buildHeroSectionMobile(context),
        tablet: _buildHeroSectionDesktop(context),
        desktop: _buildHeroSectionDesktop(context),
      ),
    );
  }

  Widget _buildHeroSectionMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeroText(),
        const SizedBox(height: AppDimens.spacing48),
        _buildHeroImage(),
      ],
    );
  }

  Widget _buildHeroSectionDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: _buildHeroText(),
        ),
        Expanded(
          flex: 5,
          child: _buildHeroImage(),
        ),
      ],
    );
  }

  Widget _buildHeroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Accelerate Product-Market Fit with AI',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.1,
          ),
        ),
        const SizedBox(height: AppDimens.spacing24),
        Text(
          'Leverage artificial intelligence to simulate real user personas and gather actionable insights for your product.',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppDimens.spacing32),
        _buildGetStartedButton(),
        const SizedBox(height: AppDimens.spacing16),
        Text(
          'No credit card required',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildGetStartedButton() {
    return Builder(
      builder: (context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.spacing32,
            vertical: AppDimens.spacing16,
          ),
        ),
        onPressed: () {
          // Navigate to sign up or demo page
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => const LoginScreen())
          );
        },
        child: const Text(
          'Get Started',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildHeroImage() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.spacing24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: AppDimens.spacing16),
              Text(
                'Persona',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spacing24),
          Container(
            height: 16,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
            ),
          ),
          const SizedBox(height: AppDimens.spacing16),
          Container(
            height: 16,
            width: double.infinity * 0.7,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
            ),
          ),
          const SizedBox(height: AppDimens.spacing16),
          Container(
            height: 16,
            width: double.infinity * 0.9,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
            ),
          ),
          const SizedBox(height: AppDimens.spacing48),
          // Simulated graph
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.radiusMedium),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.3),
                    AppColors.primary.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: CustomPaint(
                painter: CurvePainter(color: AppColors.primary),
                child: Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter to draw the curve
class CurvePainter extends CustomPainter {
  final Color color;

  CurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    var path = Path();
    
    // Start at bottom left
    path.moveTo(0, size.height * 0.7);
    
    // First curve point
    path.quadraticBezierTo(
      size.width * 0.2, 
      size.height * 0.3,
      size.width * 0.35, 
      size.height * 0.6
    );
    
    // Second curve point
    path.quadraticBezierTo(
      size.width * 0.5, 
      size.height * 0.9,
      size.width * 0.7, 
      size.height * 0.3
    );
    
    // End at bottom right
    path.quadraticBezierTo(
      size.width * 0.85, 
      size.height * 0.1,
      size.width, 
      size.height * 0.4
    );
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
} 