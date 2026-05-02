import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// R3 — ElevatedButton variant styled as an aged brass plate.
class ChoiceButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const ChoiceButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(label, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}

/// Decorative horizontal divider (vintage flourish).
class VintageDivider extends StatelessWidget {
  const VintageDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Expanded(child: Divider(color: AppTheme.sepia, thickness: 0.6)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.brightness_1, size: 6, color: AppTheme.sepia),
          ),
          const Expanded(child: Divider(color: AppTheme.sepia, thickness: 0.6)),
        ],
      ),
    );
  }
}
