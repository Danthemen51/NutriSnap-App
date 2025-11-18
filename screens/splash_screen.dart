import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  final VoidCallback onAnimationComplete;

  const SplashScreen({super.key, required this.onAnimationComplete});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {  // ✅ UBAH KE TickerProviderStateMixin
  late AnimationController _mainController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _logoRotationAnimation;
  
  late AnimationController _textController;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;
  
  late AnimationController _loadingController;
  late Animation<double> _loadingOpacityAnimation;
  
  late AnimationController _footerController;
  late Animation<double> _footerOpacityAnimation;

  @override
  void initState() {
    super.initState();
    
    // Main logo animation controller
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,  // ✅ SEMUA CONTROLLER PAKAI 'this' YANG SAMA
    );

    // Logo animations
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.1, 0.8, curve: Curves.easeInOutCubic),
    ));

    _logoRotationAnimation = Tween<double>(
      begin: -0.3,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    ));

    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,  // ✅ SEMUA CONTROLLER PAKAI 'this' YANG SAMA
    );

    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOutCubic,
    ));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    // Loading animation controller
    _loadingController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,  // ✅ SEMUA CONTROLLER PAKAI 'this' YANG SAMA
    );

    _loadingOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeIn,
    ));

    // Footer animation controller
    _footerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,  // ✅ SEMUA CONTROLLER PAKAI 'this' YANG SAMA
    );

    _footerOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _footerController,
      curve: Curves.easeIn,
    ));

    // Start animation sequence
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Step 1: Logo animation
    await _mainController.forward();
    
    // Step 2: Text animation after short delay
    await Future.delayed(const Duration(milliseconds: 300));
    await _textController.forward();
    
    // Step 3: Loading animation
    await Future.delayed(const Duration(milliseconds: 200));
    await _loadingController.forward();
    
    // Step 4: Footer animation
    await Future.delayed(const Duration(milliseconds: 200));
    await _footerController.forward();
    
    // Step 5: Wait a bit then exit
    await Future.delayed(const Duration(milliseconds: 800));
    _startExitAnimation();
  }

  void _startExitAnimation() async {
    // Reverse animations in sequence for smooth exit
    await _footerController.reverse();
    await _loadingController.reverse();
    await _textController.reverse();
    await _mainController.reverse();
    
    widget.onAnimationComplete();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _textController.dispose();
    _loadingController.dispose();
    _footerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00E676),
      body: Stack(
        children: [
          // Animated background gradient
          AnimatedBuilder(
            animation: _mainController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF00E676),
                      const Color(0xFF00C853),
                      const Color(0xFF69F0AE).withOpacity(_mainController.value),
                      const Color(0xFFB9F6CA).withOpacity(_mainController.value * 0.8),
                    ],
                    stops: const [0.0, 0.3, 0.7, 1.0],
                  ),
                ),
              );
            },
          ),

          // Animated background circles
          _buildAnimatedCircles(),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo
                _buildAnimatedLogo(),
                
                const SizedBox(height: 50),

                // Animated App Name
                _buildAnimatedText(),

                const SizedBox(height: 20),

                // Animated Tagline
                _buildAnimatedTagline(),

                const SizedBox(height: 80),

                // Animated Loading Indicator
                _buildAnimatedLoading(),
              ],
            ),
          ),

          // Animated Footer
          _buildAnimatedFooter(),
        ],
      ),
    );
  }

  Widget _buildAnimatedCircles() {
    return Stack(
      children: [
        // Circle 1
        Positioned(
          top: -80 + (100 * _mainController.value),
          right: -40 + (20 * _mainController.value),
          child: Opacity(
            opacity: _mainController.value * 0.15,
            child: Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // Circle 2
        Positioned(
          bottom: -60 + (80 * _mainController.value),
          left: -40 + (20 * _mainController.value),
          child: Opacity(
            opacity: _mainController.value * 0.12,
            child: Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // Circle 3
        Positioned(
          top: 100 + (50 * _mainController.value),
          left: -30 + (40 * _mainController.value),
          child: Opacity(
            opacity: _mainController.value * 0.1,
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..scale(_logoScaleAnimation.value)
            ..rotateZ(_logoRotationAnimation.value),
          child: Opacity(
            opacity: _logoOpacityAnimation.value,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3 * _mainController.value),
                    blurRadius: 25,
                    offset: const Offset(0, 15),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Green gradient background
                  Container(
                    width: 140,
                    height: 140,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF00E676),
                          Color(0xFF00C853),
                          Color(0xFF009624),
                        ],
                      ),
                    ),
                  ),
                  
                  // Outer ring
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 3,
                      ),
                    ),
                  ),
                  
                  // Leaf icon
                  Center(
                    child: Icon(
                      Icons.eco,
                      color: Colors.white,
                      size: 70,
                      shadows: [
                        Shadow(
                          blurRadius: 12 * _mainController.value,
                          color: Colors.black.withOpacity(0.4 * _mainController.value),
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                  
                  // Circular progress indicator
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: CircularProgressIndicator(
                      value: _mainController.value,
                      strokeWidth: 3,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedText() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return SlideTransition(
          position: _textSlideAnimation,
          child: Opacity(
            opacity: _textOpacityAnimation.value,
            child: Text(
              'NutriSnap',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                fontFamily: 'Poppins',
                letterSpacing: 2.0,
                shadows: [
                  Shadow(
                    blurRadius: 15 * _textController.value,
                    color: Colors.black.withOpacity(0.4 * _textController.value),
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedTagline() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return SlideTransition(
          position: _textSlideAnimation,
          child: Opacity(
            opacity: _textOpacityAnimation.value,
            child: Text(
              'Track Your Health Journey',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.95),
                fontFamily: 'Poppins',
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    blurRadius: 8 * _textController.value,
                    color: Colors.black.withOpacity(0.3 * _textController.value),
                    offset: const Offset(1, 1),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedLoading() {
    return AnimatedBuilder(
      animation: _loadingController,
      builder: (context, child) {
        return Opacity(
          opacity: _loadingOpacityAnimation.value,
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedFooter() {
    return Positioned(
      bottom: 50,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _footerController,
        builder: (context, child) {
          return Opacity(
            opacity: _footerOpacityAnimation.value,
            child: Column(
              children: [
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Eat Clean • Be Healthy',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(0.95),
                    fontFamily: 'Poppins',
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}