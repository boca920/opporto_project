import 'package:flutter/material.dart';

class NavItem {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });
}

class BottomNavBar extends StatelessWidget {
  final List<NavItem> items;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  const BottomNavBar({
    super.key,
    required this.items,
    this.backgroundColor = const Color(0xFF00205B),
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white70,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 88,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              final item = entry.value;
              return Expanded(
                child: GestureDetector(
                  onTap: item.onTap,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 50,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            if (!item.isActive)
                              Icon(
                                item.icon,
                                color: inactiveColor,
                                size: 24,
                              ),
                            if (item.isActive)
                              Positioned(
                                top: -15,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 8,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        item.icon,
                                        color: backgroundColor,
                                        size: 26,
                                      ),
                                    ),
                                    Text(
                                      item.label,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: item.isActive ? FontWeight.w600 : FontWeight.w400,
                                        color: item.isActive ? Colors.white : inactiveColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),

                      item.isActive?Container(): Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: item.isActive ? FontWeight.w600 : FontWeight.w400,
                          color:  inactiveColor,
                        ),
                      ) ,
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}