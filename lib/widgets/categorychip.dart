import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF26A69A) : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? const Color(0xFF26A69A) : const Color(0xFFE5E7EB),
          ),
        ),
        child: Text(
          '#$label',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}