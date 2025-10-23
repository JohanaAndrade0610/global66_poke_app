/*
 * @class SplashScreen
 * @description Clase encargada de contener el splash de la aplicación.
 * @autor Angela Andrade
 * @version 1.0 21/10/2025 Documentación y creación de la clase.
 */
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../provider/onboarding_provider.dart';
import '../provider/onboarding_state.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  // Controlador para el crecimiento del logo
  late AnimationController _zoomController;
  // Controlador de la rotación del logo
  late AnimationController _rotationController;
  // Escala de la animación
  late Animation<double> _scaleAnimation;
  // Rotación en el eje Y
  late Animation<double> _rotationYAnimation;

  /*
  * @method initState
  * @description Inicializa los controladores de animación.
  */
  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  /*
  * @method _setupAnimations
  * @description Configura las animaciones del splash.
  */
  void _setupAnimations() {
    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _scaleAnimation = Tween<double>(
      begin: 0.01,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(_zoomController);
    _rotationYAnimation = Tween<double>(
      begin: 0.0,
      end: 8.0 * 3.1416,
    ).chain(CurveTween(curve: Curves.linear)).animate(_rotationController);
  }

  /*
  * @method _startAnimations
  * @description Inicia las animaciones y configura el listener.
  */
  void _startAnimations() {
    _zoomController.forward();
    _rotationController.forward();
    _zoomController.addStatusListener(_onAnimationStatusChanged);
  }

  /*
  * @method _onAnimationStatusChanged
  * @description Maneja el cambio de estado de la animación.
  */
  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _rotationController.stop();
      // Notificar al provider que la animación terminó
      ref
          .read(onboardingControllerProvider.notifier)
          .onSplashAnimationCompleted();
    }
  }

  /*
  * @method dispose
  * @description Cierra el controlador de stream para evitar fugas de memoria.
  */
  @override
  void dispose() {
    _zoomController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Escuchar cambios en el estado para realizar la navegación a la siguiente pantalla
    ref.listen<OnboardingState>(onboardingControllerProvider, (previous, next) {
      // Si hay una ruta de navegación pendiente, ejecutarla
      if (next.navigationRoute != null && mounted) {
        // Navegar a la ruta especificada por el provider
        context.go(next.navigationRoute!);
        // Limpiar la navegación después de ejecutarla
        ref.read(onboardingControllerProvider.notifier).clearNavigation();
      }
    });

    return Scaffold(
      // Fondo blanco para el splash
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Expanded(
            child: Center(
              // Animación combinada entre escala y rotación
              child: AnimatedBuilder(
                animation: Listenable.merge([
                  _zoomController,
                  _rotationController,
                ]),
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..scale(_scaleAnimation.value)
                      ..rotateY(_rotationYAnimation.value),
                    child: child,
                  );
                },
                // Imagen utilizada en la animación
                child: Image.asset(
                  'assets/onboarding/splash.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
