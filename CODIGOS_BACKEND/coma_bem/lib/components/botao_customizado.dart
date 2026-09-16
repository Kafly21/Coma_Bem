import 'package:flutter/material.dart';

class BotaoCustomizado extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData? icon;

  const BotaoCustomizado({
    Key? key,
    required this.texto,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color bg = backgroundColor ?? const Color(0xFFF1A124);
    final Color fg = foregroundColor ?? Colors.white;
    final ButtonStyle style = ElevatedButton.styleFrom(
      backgroundColor: bg,
      foregroundColor: fg,
      padding: const EdgeInsets.symmetric(vertical: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );

    final label = Text(
      texto,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    );

    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: fg),
        label: label,
        style: style,
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: label,
    );
  }
}
