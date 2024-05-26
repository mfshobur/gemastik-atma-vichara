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
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Image(
                        image: const AssetImage(R.ASSETS_ICONS_REFLECTION_PNG),
                        color: navigationShell.currentIndex == 0 ? color.primary : null,
                        width: 25,
                      ),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Image(
                        image: const AssetImage(R.ASSETS_ICONS_NOTE_PNG),
                        color: navigationShell.currentIndex == 1 ? color.primary : null,
                        width: 25,
                      ),
                    ),
                    label: 'Notes',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Padding(
                  //     padding: const EdgeInsets.only(top: 0),
                  //     child: Image(
                  //       image: const AssetImage(R.ASSETS_ICONS_GOAL_PNG),
                  //       color: navigationShell.currentIndex == 2 ? color.primary : null,
                  //       width: 25,
                  //     ),
                  //   ),
                  //   label: 'Goals',
                  // ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Image(
                        image: const AssetImage(R.ASSETS_ICONS_PROFILE_PNG),
                        color: navigationShell.currentIndex == 2 ? color.primary : null,
                        width: 25,
                      ),
                    ),
                    label: 'Profile',
                  ),
                ],
                // currentIndex: _calculateSelectedIndex(context),
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
