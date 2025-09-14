import 'package:flutter/material.dart';
import 'package:minders/core/models/health_data.dart';

class HealthCard extends StatelessWidget {
  final HealthData data;

  const HealthCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: data.color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(data.icon, style: const TextStyle(fontSize: 20)),
                ),
              ),
              Text(
                '${data.percentage.toInt()}%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: data.color,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            data.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          _buildProgressCircle(),
        ],
      ),
    );
  }

  Widget _buildProgressCircle() {
    return Stack(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            value: data.percentage / 100,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(data.color),
            strokeWidth: 6,
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Text(
              '${data.percentage.toInt()}%',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: data.color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}