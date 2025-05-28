import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/common/common.dart';
import 'splash_screen_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initializeApp();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(); // 🔥 Ahora sin reverse para movimiento continuo

    _animation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    try {
      // ✅ Espera a que termine la carga de los datos iniciales
      // await ref.read(appInitProvider.future);

      // ✅ Espera los 3 segundos del splash
      await Future.delayed(const Duration(seconds: 5));

      // ✅ Solo si el widget sigue montado
      if (!mounted) return;

      // ✅ Marca el splash como completado
      ref.read(splashCompletedProvider.notifier).state = true;
    } catch (e) {
      // Manejar error si quieres, o mostrarlo en el splash
      debugPrint("Error al inicializar: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonPageScaffold(
      title: '',
      showAppBar: false,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRect(
                      child: Image(
                        image: const AssetImage('assets/icons/barber-icon.png'),
                        height: 150,
                      ),
                    ),

                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Barber Shop',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Agenda tu cita en segundos.',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        const Text(
                          textAlign: TextAlign.center,
                          'Estamos cargando las últimas actualizaciones',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10,),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
