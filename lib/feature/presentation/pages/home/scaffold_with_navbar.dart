import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../const/resource.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  void _onItemTapped(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final bigScreen = MediaQuery.of(context).size.width > 480;
    const double iconSize = 20;

    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 480,
          ),
          child: navigationShell,
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: bigScreen ? 0 : 1,
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 480,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: color.shadow.withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 14.0,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 64,
                      height: 32,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: navigationShell.currentIndex == 0
                            ? color.surfaceVariant
                            : color.surface,
                      ),
                      child: Image(
                        image: const AssetImage(R.ASSETS_ICONS_REFLECTION_PNG),
                        color: navigationShell.currentIndex == 0 ? color.primary : null,
                        width: iconSize,
                      ),
                    ),
                    label: 'Reflect',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 64,
                      height: 32,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: navigationShell.currentIndex == 1
                            ? color.surfaceVariant
                            : color.surface,
                      ),
                      child: Image(
                        image: const AssetImage(R.ASSETS_ICONS_NOTE_PNG),
                        color: navigationShell.currentIndex == 1 ? color.primary : null,
                        width: iconSize,
                      ),
                    ),
                    label: 'Notes',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 64,
                      height: 32,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: navigationShell.currentIndex == 2
                            ? color.surfaceVariant
                            : color.surface,
                      ),
                      child: Image(
                        image: const AssetImage(R.ASSETS_ICONS_PROFILE_PNG),
                        color: navigationShell.currentIndex == 2 ? color.primary : null,
                        width: iconSize,
                      ),
                    ),
                    label: 'Profile',
                  ),
                ],
                currentIndex: navigationShell.currentIndex,
                onTap: (int idx) => _onItemTapped(idx, context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
