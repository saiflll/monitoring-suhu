import 'package:flutter/material.dart';

class TableDetailFilterBar extends StatelessWidget {
  const TableDetailFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEAF6FF), // Warna background sesuai contoh
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Baris Atas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Table Detail',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  _buildDropdownButton(title: 'Area Name'),
                  const SizedBox(width: 12),
                  _buildDropdownButton(title: 'Device Name'),
                ],
              )
            ],
          ),

          const SizedBox(height: 12),

          // Baris Bawah
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDropdownButton(title: '1h'),
              Row(
                children: [
                  _buildDropdownButton(title: 'From - To', icon: Icons.calendar_today),
                  const SizedBox(width: 12),
                  _buildDropdownButton(title: 'Export', icon: Icons.download),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownButton({required String title, IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16),
            const SizedBox(width: 8),
          ],
          Text(title),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_drop_down, size: 16),
        ],
      ),
    );
  }
}