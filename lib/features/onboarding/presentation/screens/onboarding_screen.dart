/*
 * @class OnboardingScreen
 * @description Clase encargada de contener la pantalla de Onboarding con dos páginas informativas sobre la aplicación.
 * @autor Angela Andrade
 * @version 1.0 21/10/2025 Documentación y creación de la clase.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/onboarding_page_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controlador del PageView
  final PageController _pageController = PageController();
  // Página actual
  int _currentPage = 0;

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
  * @description Navega a la siguiente página o a la pantalla principal.
  */
  void _onContinue() {
    if (_currentPage < 1) {
      // Ir a la siguiente página
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Navegar a la pantalla principal (Pokedex)
      context.go('/pokedex');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Internacionalización de textos
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      // Fondo blanco para la pantalla de onboarding
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // PageView con las páginas de onboarding
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
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
                    width: _currentPage == index ? 28 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
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
                child: ElevatedButton(
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue1E88E5,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage == 0
                        ? l10n.onboardingContinueButton
                        : l10n.onboardingStartButton,
                    style: AppColors.textPoppins16SemiBoldFFFFFF,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
