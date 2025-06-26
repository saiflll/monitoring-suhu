import 'package:flutter/material.dart';
import '../../config/color.dart';

// Helper widget untuk styling card putih yang umum
class CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Border? border;
  final double? height;

  const CardContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.border,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: border ?? Border.all(color: const Color.fromARGB(25, 0, 0, 0)), // Border default yang halus
        borderRadius: borderRadius ?? BorderRadius.circular(8), // Radius default
      ),
      child: child,
    );
  }
}

// Helper widget untuk styling container bagian (section) yang umum
class SectionContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const SectionContainer({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(0, 158, 158, 158)), // Border transparan
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }
}

// Placeholder box yang direfaktor untuk menggunakan CardContainer
class PlaceholderBox extends StatelessWidget {
  final String text;
  final double? height;

  const PlaceholderBox(this.text, {super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      height: height,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54),
        ),
      ),
    );
  }
}