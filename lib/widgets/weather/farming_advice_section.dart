import 'package:flutter/material.dart';
import '../../models/app_models.dart';

class FarmingAdviceSection extends StatelessWidget {
  final List<FarmingAdvice> advice;

  const FarmingAdviceSection({
    super.key,
    required this.advice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Farming Advice',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        if (advice.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'No specific farming advice available at the moment.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          ...advice.map((adviceItem) => _buildAdviceCard(adviceItem)),
      ],
    );
  }

  Widget _buildAdviceCard(FarmingAdvice advice) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getColorFromString(advice.color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getIconFromString(advice.icon),
                color: _getColorFromString(advice.color),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          advice.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(advice.priority),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          advice.priority.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    advice.content,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      advice.category,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getColorFromString(String colorString) {
    switch (colorString.toLowerCase()) {
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'yellow':
        return Colors.yellow;
      case 'teal':
        return Colors.teal;
      case 'pink':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  IconData _getIconFromString(String iconString) {
    switch (iconString.toLowerCase()) {
      case 'water_drop':
        return Icons.water_drop;
      case 'bug_report':
        return Icons.bug_report;
      case 'local_florist':
        return Icons.local_florist;
      case 'healing':
        return Icons.healing;
      case 'thermometer':
        return Icons.thermostat;
      case 'ac_unit':
        return Icons.ac_unit;
      case 'grain':
        return Icons.grain;
      case 'wb_sunny':
        return Icons.wb_sunny;
      case 'air':
        return Icons.air;
      case 'agriculture':
        return Icons.agriculture;
      case 'eco':
        return Icons.eco;
      case 'nature':
        return Icons.nature;
      case 'park':
        return Icons.park;
      default:
        return Icons.info;
    }
  }
}
