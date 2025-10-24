/*
 * @class OnboardingScreen
 * @description Clase encargada de contener la pantalla de Onboarding con dos páginas informativas sobre la aplicación.
 * @autor Angela Andrade
 * @version 1.0 21/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/custom_loading.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../provider/onboarding_provider.dart';
import '../provider/onboarding_state.dart';
import '../widgets/onboarding_page_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controlador del PageView
  final PageController _pageController = PageController();

  /*
  * @method dispose
  * @description Libera los recursos del PageController cuando el widget se elimina.
  */
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /*
  * @method _onContinue
  * @description Navega a la siguiente página de onboarding o llama a la API para obtener datos.
  */
  void _onContinue(WidgetRef ref) async {
    final currentPage = ref.read(onboardingControllerProvider).currentPage;
    if (currentPage < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      await ref.read(onboardingControllerProvider.notifier).callApiPokedex();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer(
      builder: (context, ref, _) {
        final onboardingState = ref.watch(onboardingControllerProvider);
        // Escuchar cambios en el estado para navegación
        ref.listen<OnboardingState>(onboardingControllerProvider, (
          previous,
          next,
        ) {
          if (next.navigationRoute != null && mounted) {
            context.push(next.navigationRoute!);
            ref.read(onboardingControllerProvider.notifier).clearNavigation();
          }
        });
        return Scaffold(
          // Fondo blanco para la pantalla de onboarding
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    // PageView con las páginas de onboarding
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          ref
                              .read(onboardingControllerProvider.notifier)
                              .setCurrentPage(index);
                        },
                        children: [
                          // Primera página de onboarding
                          OnboardingPageWidget(
                            imagePath: 'assets/onboarding/onboarding_01.png',
                            title: l10n.onboardingTittle01,
                            description: l10n.onboardingDescription01,
                          ),
                          // Segunda página de onboarding
                          OnboardingPageWidget(
                            imagePath: 'assets/onboarding/onboarding_02.png',
                            title: l10n.onboardingTittle02,
                            description: l10n.onboardingDescription02,
                          ),
                        ],
                      ),
                    ),
                    // Indicadores de página
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          2,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: onboardingState.currentPage == index
                                ? 28
                                : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: onboardingState.currentPage == index
                                  ? AppColors.blue173EA5
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Botón de continuar/empezar
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
                      child: SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: AbsorbPointer(
                          absorbing: onboardingState.loading,
                          child: ElevatedButton(
                            onPressed: () => _onContinue(ref),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blue1E88E5,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              onboardingState.currentPage == 0
                                  ? l10n.onboardingContinueButton
                                  : l10n.onboardingStartButton,
                              style: AppTextStyles.textPoppins16SemiBoldFFFFFF,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (onboardingState.loading)
                Positioned.fill(child: IgnorePointer(child: CustomLoading())),
            ],
          ),
        );
      },
    );
  }
}
