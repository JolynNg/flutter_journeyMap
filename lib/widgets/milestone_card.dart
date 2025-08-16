
import 'package:flutter/material.dart';
import 'package:law_app/model/milestone.dart';

class MotivationalMilestoneCard extends StatelessWidget {
  final MotivationalMilestone milestone;
  final int checkpointNumber;
  final bool isExpanded;
  final VoidCallback onTap;

  const MotivationalMilestoneCard({
    super.key,
    required this.milestone,
    required this.checkpointNumber,
    required this.isExpanded,
    required this.onTap,  
  });

  @override
  Widget build(BuildContext context) {
    Color cardColor;
    Color iconColor;
    Color textColor;
    Widget statusWidget;
    IconData milestoneIcon;

    switch(milestone.status) {
      case MilestoneStatus.completed:
        cardColor = Colors.green.shade50;
        iconColor = Colors.green;
        textColor = Colors.green.shade800;
        milestoneIcon = milestone.icon;
        statusWidget = Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check, color: Colors.white, size: 14),
              SizedBox(width: 4),
              Text(
                'ACHIEVED',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
        break;
        case MilestoneStatus.current:
        cardColor = Colors.blue.shade50;
        iconColor = Colors.blue;
        textColor = Colors.blue.shade800;
        milestoneIcon = milestone.icon;
        statusWidget = Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.play_arrow, color: Colors.white, size: 14),
              SizedBox(width: 4),
              Text(
                'CURRENT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
        break;
        case MilestoneStatus.upcoming:
          cardColor = Colors.orange.shade50;
          iconColor = Colors.orange;
          textColor = Colors.orange.shade800;
          milestoneIcon = milestone.icon;
          statusWidget = Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.schedule, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text(
                  'COMING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
          break;
          case MilestoneStatus.future:
            cardColor = Colors.grey.shade50;
            iconColor = Colors.grey;
            textColor = Colors.grey.shade700;
            milestoneIcon = Icons.lock_outline;
            statusWidget = Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Text(
                'LOCKED',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
            break;
    }
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: milestone.status == MilestoneStatus.current 
                ? iconColor.withOpacity(0.5)
                : milestone.status == MilestoneStatus.completed
                    ? iconColor.withOpacity(0.5)
                    : Colors.transparent,
            width: milestone.status == MilestoneStatus.current ? 2 : 1,
          ),
          boxShadow: milestone.status == MilestoneStatus.completed ||
                     milestone.status == MilestoneStatus.current
              ? [
                BoxShadow(
                  color: iconColor.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: iconColor.withOpacity(0.3)),
                  ),
                  child: Icon(
                    milestoneIcon,
                    color: iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              milestone.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ),
                          statusWidget,
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        milestone.timeframe,
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: iconColor,
                ),
              ],
            ),
            if(isExpanded) ...[
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.format_quote,
                      color: iconColor,
                      size: 24,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      milestone.motivationQuote,
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: textColor,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      milestone.encouragement,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor.withOpacity(0.9),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (milestone.achievement.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.start, color: iconColor, size: 16),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                milestone.achievement,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}