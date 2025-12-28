import 'package:currency_converter/common/animations/app_animations.dart';
import 'package:currency_converter/common/bottom_navBar/models/navbar_model.dart';
import 'package:currency_converter/core/extension/extensions.dart';
import 'package:currency_converter/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavBarItem extends StatelessWidget {
  final NavbarModel navbarModel;
  final bool isActive;

  const BottomNavBarItem({
    super.key,
    required this.navbarModel,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return isActive ? _activeTab(context) : _unActiveTab();
  }

  Widget _unActiveTab() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(navbarModel.icon, color: Colors.black54),
          4.heightBox,
          Text(
            navbarModel.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _activeTab(context) {
    return AnimatedActiveTabIcon(
      icon: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(navbarModel.icon, color: Colors.white),
            const SizedBox(height: 4),
            Text(
              navbarModel.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
