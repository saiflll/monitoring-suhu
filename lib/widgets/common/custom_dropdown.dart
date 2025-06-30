import 'package:flutter/material.dart';
import '../../config/color.dart';

class CustomDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final double? height; // Added height property
  final EdgeInsetsGeometry? padding; // Added padding property
  final BorderRadiusGeometry? borderRadius; // Added borderRadius property
  final Color? backgroundColor; // Added backgroundColor property

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.height,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white, // Default to white
        borderRadius: borderRadius ?? BorderRadius.circular(15), // Default radius
      ),
      child: DropdownButton<String>(        
        value: value,
        isExpanded: true, // <-- TAMBAHKAN INI
        style: const TextStyle(
          color: AppColors.black,
          fontSize: 14,
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text( // Hapus Center yang tidak perlu
              item,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: onChanged,
        underline: Container(), // Menghilangkan garis bawah
      ),
    );
  }
}