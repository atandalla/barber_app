import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class IconBackground extends StatefulWidget {
  final Widget child;
  const IconBackground({super.key, required this.child});

  @override
  State<IconBackground> createState() => _IconBackgroundState();
}

class _IconBackgroundState extends State<IconBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_FloatingIcon> _icons;

  final int _numIcons = 25;
  final List<IconData> _availableIcons = [
    Icons.spa,
    
    Icons.face_6_outlined,
    Icons.chair,
    Icons.cut,
    
    Icons.male,
    Icons.storefront,
  ];

  @override
  void initState() {
    super.initState();

    final random = Random();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();

    _icons = List.generate(_numIcons, (index) {
      final icon = _availableIcons[random.nextInt(_availableIcons.length)];
      return _FloatingIcon(
        icon: icon,
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 24 + 16,
        speed: random.nextDouble() * 0.0005 + 0.0002,
        opacity: random.nextDouble() * 0.2 + 0.1,
        rotation: random.nextDouble() * 360,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return CustomPaint(
              painter: _IconPainter(
                icons: _icons,
                progress: _controller.value,
              ),
              size: MediaQuery.of(context).size,
            );
          },
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(color: Colors.white.withOpacity(0.05)),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _FloatingIcon {
  final IconData icon;
  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;
  final double rotation;

  _FloatingIcon({
    required this.icon,
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.rotation,
  });

  double positionY(double progress) {
    return (y - speed * progress * 1000) % 1.0;
  }
}

class _IconPainter extends CustomPainter {
  final List<_FloatingIcon> icons;
  final double progress;

  _IconPainter({required this.icons, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final iconData in icons) {
      final dx = iconData.x * size.width;
      final dy = (1.0 - iconData.positionY(progress)) * size.height;

      final textPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(iconData.icon.codePoint),
          style: TextStyle(
            fontSize: iconData.size,
            fontFamily: iconData.icon.fontFamily,
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(iconData.opacity),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(iconData.rotation * pi / 180);
      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
