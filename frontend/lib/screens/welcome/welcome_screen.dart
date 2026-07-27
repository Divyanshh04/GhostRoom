import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import '../create_room/create_room_screen.dart';
import '../join_room/join_room_screen.dart';

// ---- Cyberpunk Palette (Enhanced Luminance) ----
import '../../theme/cyber_palette.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CyberPalette.bgTop,
      body: Stack(
        children: [
          // 1. Base Gradient Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [CyberPalette.bgTop, CyberPalette.bgBottom],
                ),
              ),
            ),
          ),

          // 2. High-Tech Background Cyber Grid
          Positioned.fill(
            child: CustomPaint(
              painter: _CyberGridPainter(),
            ),
          ),

          // 3. Faint Ambient Glowing Orbs
          Positioned(
            top: -100,
            left: -80,
            child: const _GlowOrb(
              color: CyberPalette.neonCyan,
              size: 320,
              opacity: 0.15,
            ),
          ),
          Positioned(
            bottom: -120,
            right: -100,
            child: const _GlowOrb(
              color: CyberPalette.neonMagenta,
              size: 380,
              opacity: 0.12,
            ),
          ),

          // 4. Foreground Content Layer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(flex: 3),

                  // ---- Signature Element: Animated Ghost Badge ----
                  const _GhostBadge(),

                  const SizedBox(height: 28),

                  // Title: Dual Neon Gradient + Multi-Layer Glow
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [CyberPalette.neonCyan, Color(0xFF8A2BE2), CyberPalette.neonMagenta],
                      stops: [0.0, 0.5, 1.0],
                    ).createShader(bounds),
                    child: const Text(
                      "GHOSTROOM",
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 8,
                        color: Colors.white,
                        shadows: [
                          Shadow(color: CyberPalette.neonCyan, blurRadius: 24),
                          Shadow(color: CyberPalette.neonMagenta, blurRadius: 40),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Status Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: CyberPalette.neonGreen,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: CyberPalette.neonGreen, blurRadius: 8, spreadRadius: 2),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "> stay_invisible_",
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: CyberPalette.neonGreen,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Subtitle Specs
                  const Text(
                    "PRIVATE  •  TEMPORARY  •  SECURE",
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: CyberPalette.slate,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4,
                    ),
                  ),

                  const Spacer(flex: 4),

                  // ---- CREATE ROOM Button ----
                  _NeonFilledButton(
                    label: "CREATE ROOM",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CreateRoomScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // ---- Terminal-Style Divider ----
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [CyberPalette.slate.withOpacity(0.0), CyberPalette.slate.withOpacity(0.4)],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "// OR //",
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: CyberPalette.slate.withOpacity(0.7),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [CyberPalette.slate.withOpacity(0.4), CyberPalette.slate.withOpacity(0.0)],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ---- JOIN ROOM Button ----
                  _NeonOutlineButton(
                    label: "JOIN ROOM",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const JoinRoomScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // Footer Version Tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.02),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: Text(
                      "[ ghostroom v1.0 ]",
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: CyberPalette.slate.withOpacity(0.8),
                        fontSize: 11,
                        letterSpacing: 2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SUB-COMPONENTS & ANIMATIONS
// =============================================================================

/// Ambient soft-glow radial orb with hardware acceleration.
class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size;
  final double opacity;

  const _GlowOrb({
    required this.color,
    required this.size,
    required this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(opacity),
            color.withOpacity(opacity * 0.4),
            color.withOpacity(0),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }
}

/// Floating, pulsating Cyberpunk Ghost Badge with crosshair ticks and target reticle.
class _GhostBadge extends StatefulWidget {
  const _GhostBadge();

  @override
  State<_GhostBadge> createState() => _GhostBadgeState();
}

class _GhostBadgeState extends State<_GhostBadge> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final floatOffset = math.sin(_controller.value * math.pi) * 6.0;
        final pulseOpacity = 0.25 + (math.sin(_controller.value * math.pi) * 0.15);

        return Transform.translate(
          offset: Offset(0, floatOffset),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer Glowing Aura Ring
              Container(
                width: 154,
                height: 154,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: CyberPalette.neonCyan.withOpacity(pulseOpacity),
                      blurRadius: 40,
                      spreadRadius: 8,
                    ),
                  ],
                ),
              ),

              // Outer Reticle Line Ring
              CustomPaint(
                size: const Size(150, 150),
                painter: _ReticlePainter(progress: _controller.value),
              ),

              // Frosted Glass Layer Container
              ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 120,
                    height: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF090D16).withOpacity(0.5),
                      border: Border.all(
                        color: CyberPalette.neonCyan.withOpacity(0.7),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: CyberPalette.neonMagenta.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    child: Container(
                      width: 92,
                      height: 92,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3),
                        border: Border.all(
                          color: CyberPalette.neonMagenta.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        "👻",
                        style: TextStyle(
                          fontSize: 54,
                          shadows: [
                            Shadow(color: CyberPalette.neonCyan, blurRadius: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Primary CTA — Gradient fill with reactive touch animation and vibrant outer bloom.
class _NeonFilledButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _NeonFilledButton({required this.label, required this.onPressed});

  @override
  State<_NeonFilledButton> createState() => _NeonFilledButtonState();
}

class _NeonFilledButtonState extends State<_NeonFilledButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [CyberPalette.neonCyan, Color(0xFFB02EFF), CyberPalette.neonMagenta],
            ),
            boxShadow: [
              BoxShadow(
                color: CyberPalette.neonCyan.withOpacity(_isPressed ? 0.7 : 0.45),
                blurRadius: _isPressed ? 24 : 16,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: CyberPalette.neonMagenta.withOpacity(0.3),
                blurRadius: 30,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  color: Color(0xFF030408),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 18,
                color: Color(0xFF030408),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Secondary CTA — Frosted Glass Outline with neon glowing borders.
class _NeonOutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _NeonOutlineButton({required this.label, required this.onPressed});

  @override
  State<_NeonOutlineButton> createState() => _NeonOutlineButtonState();
}

class _NeonOutlineButtonState extends State<_NeonOutlineButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(_isPressed ? 0.08 : 0.03),
                border: Border.all(
                  color: CyberPalette.neonCyan.withOpacity(_isPressed ? 1.0 : 0.6),
                  width: 1.5,
                ),
                boxShadow: _isPressed
                    ? [
                        BoxShadow(
                          color: CyberPalette.neonCyan.withOpacity(0.3),
                          blurRadius: 16,
                        )
                      ]
                    : [],
              ),
              child: Center(
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 4,
                    color: CyberPalette.neonCyan,
                    shadows: [
                      Shadow(color: CyberPalette.neonCyan, blurRadius: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// CUSTOM PAINTERS
// =============================================================================

/// Renders a subtle cyberpunk background grid with edge fade.
class _CyberGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CyberPalette.neonCyan.withOpacity(0.04)
      ..strokeWidth = 1.0;

    const spacing = 32.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Draws high-tech target reticle ticks around the hero ghost badge.
class _ReticlePainter extends CustomPainter {
  final double progress;

  _ReticlePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = CyberPalette.neonCyan.withOpacity(0.4)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw dashed outer border ticks
    const tickCount = 8;
    for (int i = 0; i < tickCount; i++) {
      final angle = (i * (2 * math.pi / tickCount)) + (progress * math.pi * 0.2);
      final start = Offset(
        center.dx + (radius - 6) * math.cos(angle),
        center.dy + (radius - 6) * math.sin(angle),
      );
      final end = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ReticlePainter oldDelegate) =>
      oldDelegate.progress != progress;
}