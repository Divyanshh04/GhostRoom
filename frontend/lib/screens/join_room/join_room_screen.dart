import 'dart:ui';
import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import '../chat/chat_screen.dart';

// ---- Cyberpunk Palette (Matches WelcomeScreen) ----
import '../../theme/cyber_palette.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController roomCodeController = TextEditingController();
  final ApiService apiService = ApiService();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {}); // Triggers dynamic glow on input focus
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    roomCodeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CyberPalette.bgTop,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Navigator.maybePop(context),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: CyberPalette.neonCyan.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: CyberPalette.neonCyan,
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          "JOIN ROOM",
          style: TextStyle(
            fontFamily: 'monospace',
            letterSpacing: 4,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: CyberPalette.neonCyan,
            shadows: [
              Shadow(color: CyberPalette.neonCyan, blurRadius: 12),
            ],
          ),
        ),
      ),
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

          // 2. High-Tech Cyber Grid Background
          Positioned.fill(
            child: CustomPaint(
              painter: _CyberGridPainter(),
            ),
          ),

          // 3. Faint Ambient Glowing Orbs
          Positioned(
            top: -100,
            right: -80,
            child: const _GlowOrb(
              color: CyberPalette.neonMagenta,
              size: 320,
              opacity: 0.12,
            ),
          ),
          Positioned(
            bottom: -120,
            left: -100,
            child: const _GlowOrb(
              color: CyberPalette.neonCyan,
              size: 380,
              opacity: 0.12,
            ),
          ),

          // 4. Foreground Form Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // Header Section
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [CyberPalette.neonCyan, Color(0xFFB02EFF), CyberPalette.neonMagenta],
                    ).createShader(bounds),
                    child: const Text(
                      "Choose a username",
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(color: CyberPalette.neonCyan, blurRadius: 16),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
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
                      Text(
                        "> visible to everyone in the room_",
                        style: TextStyle(
                          fontFamily: 'monospace',
                          color: CyberPalette.slate,
                          fontSize: 13,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 36),

                  // ---- High-Tech Glassmorphic Input Field ----
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: _focusNode.hasFocus
                          ? [
                              BoxShadow(
                                color: CyberPalette.neonCyan.withOpacity(0.25),
                                blurRadius: 20,
                                spreadRadius: 1,
                              )
                            ]
                          : [],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.03),
                            border: Border.all(
                              color: _focusNode.hasFocus
                                  ? CyberPalette.neonCyan
                                  : CyberPalette.neonCyan.withOpacity(0.4),
                              width: _focusNode.hasFocus ? 1.6 : 1.2,
                            ),
                          ),
                          child: TextField(
                            controller: usernameController,
                            focusNode: _focusNode,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                            cursorColor: CyberPalette.neonCyan,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 18, right: 10),
                                child: Text(
                                  ">",
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    color: _focusNode.hasFocus ? CyberPalette.neonGreen : CyberPalette.slate,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              prefixIconConstraints: const BoxConstraints(
                                minWidth: 0,
                                minHeight: 0,
                              ),
                              hintText: "enter_username",
                              hintStyle: TextStyle(
                                fontFamily: 'monospace',
                                color: CyberPalette.slate.withOpacity(0.6),
                                letterSpacing: 1.5,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 18,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),const SizedBox(height: 28),

Text(
  "Enter room code",
  style: TextStyle(
    fontFamily: 'monospace',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: CyberPalette.neonCyan,
    letterSpacing: 1.2,
  ),
),

const SizedBox(height: 8),

Text(
  "> ask your friend for the room code_",
  style: TextStyle(
    fontFamily: 'monospace',
    color: CyberPalette.slate,
    fontSize: 12,
    letterSpacing: 0.8,
  ),
),

const SizedBox(height: 20),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: _focusNode.hasFocus
                          ? [
                              BoxShadow(
                                color: CyberPalette.neonCyan.withOpacity(0.25),
                                blurRadius: 20,
                                spreadRadius: 1,
                              )
                            ]
                          : [],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.03),
                            border: Border.all(
                              color: _focusNode.hasFocus
                                  ? CyberPalette.neonCyan
                                  : CyberPalette.neonCyan.withOpacity(0.4),
                              width: _focusNode.hasFocus ? 1.6 : 1.2,
                            ),
                          ),
                          child: TextField(
                            controller: roomCodeController,
                            focusNode: _focusNode,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                            cursorColor: CyberPalette.neonCyan,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(left: 18, right: 10),
                                child: Text(
                                  ">",
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    color: _focusNode.hasFocus ? CyberPalette.neonGreen : CyberPalette.slate,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              prefixIconConstraints: const BoxConstraints(
                                minWidth: 0,
                                minHeight: 0,
                              ),
                              hintText: "enter_room_code",
                              hintStyle: TextStyle(
                                fontFamily: 'monospace',
                                color: CyberPalette.slate.withOpacity(0.6),
                                letterSpacing: 1.5,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 18,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 56),
                
                  // ---- CREATE ROOM Button ----
                 _NeonFilledButton(
  label: "JOIN ROOM",
  onPressed: () async {
    final username = usernameController.text.trim();
    final roomCode = roomCodeController.text.trim();

    if (username.isEmpty || roomCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter username and room code"),
        ),
      );
      return;
    }

    try {
      final room = await apiService.joinRoom(
        int.parse(roomCode),
        username,
      );

final myUser = room.participants.firstWhere(
  (participant) => participant.username == username,
);

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ChatScreen(
      username: username,
      roomCode: room.roomCode,
      userId: myUser.userId,
    ),
  ),
);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  },
),
                    
                  
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
// SUB-COMPONENTS & CUSTOM PAINTERS
// =============================================================================

/// Ambient soft-glow radial orb.
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

/// Primary CTA — Gradient fill with reactive touch animation and bloom glow.
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

/// Renders a subtle cyberpunk background grid.
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