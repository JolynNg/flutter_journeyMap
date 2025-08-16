import 'package:flutter/material.dart';
import 'dart:math';
import 'package:law_app/model/milestone.dart';
import 'package:law_app/widgets/milestone_card.dart';

class MotivationalJourneyPage extends StatefulWidget{
  const MotivationalJourneyPage({super.key});

  @override
  _MotivationalJourneyPageState createState() => _MotivationalJourneyPageState();
}

class _MotivationalJourneyPageState extends State<MotivationalJourneyPage> with TickerProviderStateMixin {

  late AnimationController _progressController;
  late AnimationController _celebrationController;
  late Animation<double> _bounceAnimation;
  late Animation<double> _progressAnimation;

  bool _showDailyMotivation = false;
  int _selectedMilestone = -1; // -1 means no milestone is selected

  final List<String> dailyMotivations = [
    "You're not just studying law - you're becoming a voice for justice! 💪",
    "Every page you read brings you closer to your dreams! 📚✨",
    "Stage 1 is DONE! You've already proven you can conquer anything! 🎉",
    "Legal minds are built one day at a time - you're building yours! 🧠",
    "Your future clients are counting on your dedication today! ⚖️",
    "Champions aren't made in comfort zones - you're in training! 🏆",
    "You're not just passing exams - you're unlocking your potential! 🗝️",
  ];

  @override
  void initState() {
    super.initState();

    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _celebrationController,
        curve: Curves.elasticOut,
      ),
    );

    double targetProgress = _calculateOverallProgress();
    _progressAnimation = Tween<double>(begin: 0.0, end: targetProgress).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeOutCubic,
      )
    );
      
    Future.delayed(const Duration(milliseconds: 500), () {
      _progressController.forward();
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      _celebrationController.forward().then((_) {
        _celebrationController.reverse();
      });
    });

  }

  @override
  void dispose() {
    _progressController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  double _calculateOverallProgress() {
    int completedMilestones = motivationalMilestones.where((m) => m.status == MilestoneStatus.completed).length;
    return completedMilestones / motivationalMilestones.length;
  }

  MotivationalMilestone? _getCurrentMilestone() {
    try {
      return motivationalMilestones.firstWhere((m) => m.status == MilestoneStatus.current);
    } catch (e) {
      return null;
    }
  }

  MotivationalMilestone? _getMilestone() {
    try {
      return motivationalMilestones.firstWhere((m) => m.status == MilestoneStatus.upcoming);
    } catch (e) {
      return null;
    }
  }

  MotivationalMilestone? _getNextMilestone() {
    try {
      return motivationalMilestones.firstWhere((m) => m.status == MilestoneStatus.upcoming);
    } catch (e) {
      return null;
    }
  }
   
  int _getCompletedMilestones() {
    return motivationalMilestones.where((m) => m.status == MilestoneStatus.completed).length;
  }

  String _getRandomDailyMotivation() {
    final random = Random();
    return dailyMotivations[random.nextInt(dailyMotivations.length)];
  }

  void _toggleDailyMotivation() {
    setState(() {
      _showDailyMotivation = !_showDailyMotivation;
    });
  }

  void _selectMilestone(int index) {
    setState(() {
      _selectedMilestone = _selectedMilestone == index ? -1 : index;
    });
  }


  @override
  Widget build(BuildContext context) {

    final completedMilestones = _getCompletedMilestones();
    final totalMilestones = motivationalMilestones.length;
    final currentMilestone = _getCurrentMilestone();
    final nextMilestone = _getNextMilestone();

     return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8EAF6), // Indigo.shade50
              Color(0xFFF3E5F5), // Purple.shade50
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                const SizedBox(height: 10),
                Row(
                  children: [
                    AnimatedBuilder(
                      animation: _bounceAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _bounceAnimation.value,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Motivation Journey',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            'Checkpoint $completedMilestones of $totalMilestones reached',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${((completedMilestones / totalMilestones) * 100).toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 25),
                
                // Current achievement highlight
                if (currentMilestone != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.psychology,
                                color: Colors.blue.shade600,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current Motivation Phase',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    currentMilestone.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: _progressAnimation.value,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                                minHeight: 8,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 15),
                        Text(
                          currentMilestone.motivationQuote,
                          style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.deepPurple,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _toggleDailyMotivation,
                      icon: Icon(_showDailyMotivation ? Icons.close : Icons.bolt),
                      label: Text(_showDailyMotivation ? 'Hide Daily Boost' : 'Daily Motivation Boost'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                    ),
                  ),

                  if(_showDailyMotivation) ...[
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.amber.shade200),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.wb_sunny,
                                color: Colors.amber,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Today\'s Motivation',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            _getRandomDailyMotivation(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.amber.shade800,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: Text(
                              '🎉 Remember: You CONQUERED Stage 1! 🎉\nStage 2 in 2 months - You\'ve got this! 💪',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Motivation Checkpoints',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Text(
                        'Tap for inspiration',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Expanded(
                    child: ListView.builder(
                      itemCount: motivationalMilestones.length,
                      itemBuilder: (context, index) {
                        final milestone = motivationalMilestones[index];
                        final isExpanded = _selectedMilestone == index;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: MotivationalMilestoneCard(
                            milestone: milestone,
                            checkpointNumber: index + 1,
                            isExpanded: isExpanded,
                            onTap: () => _selectMilestone(index),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

