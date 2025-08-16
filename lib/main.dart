import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motivational Journey Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MotivationalJourneyPage(),
    );
  }
}

class MotivationalJourneyPage extends StatefulWidget {
  const MotivationalJourneyPage({super.key});

  @override
  State<MotivationalJourneyPage> createState() => _MotivationalJourneyPageState();
}

class _MotivationalJourneyPageState extends State<MotivationalJourneyPage>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _celebrationController;
  late Animation<double> _progressAnimation;
  late Animation<double> _bounceAnimation;
  
  bool _showDailyMotivation = false;
  int _selectedMilestone = -1;
  
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
    
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    // Calculate progress based on completed milestones
    double targetProgress = _calculateOverallProgress();
    _progressAnimation = Tween<double>(begin: 0.0, end: targetProgress).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOutCubic),
    );
    
    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _celebrationController, curve: Curves.elasticOut),
    );
    
    // Start animations
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

  int _getCompletedMilestones() {
    return motivationalMilestones.where((m) => m.status == MilestoneStatus.completed).length;
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

  MotivationalMilestone? _getCurrentMilestone() {
    try {
      return motivationalMilestones.firstWhere((m) => m.status == MilestoneStatus.current);
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

  String _getRandomDailyMotivation() {
    final random = Random();
    return dailyMotivations[random.nextInt(dailyMotivations.length)];
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
                
                // Daily motivation toggle
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
                
                // Daily motivation section
                if (_showDailyMotivation) ...[
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
                              fontSize: 14,
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
                
                // Motivation milestones header
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
                
                // Milestones list
                Expanded(
                  child: ListView.builder(
                    itemCount: motivationalMilestones.length,
                    itemBuilder: (context, index) {
                      final milestone = motivationalMilestones[index];
                      final isExpanded = _selectedMilestone == index;
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
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

    switch (milestone.status) {
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
                  ? iconColor.withOpacity(0.3)
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
                // Icon circle
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
                
                // Title and status
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
            
            // Expanded motivation content
            if (isExpanded) ...[
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
                            Icon(Icons.star, color: iconColor, size: 16),
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

enum MilestoneStatus { completed, current, upcoming, future }

class MotivationalMilestone {
  final String title;
  final String timeframe;
  final String motivationQuote;
  final String encouragement;
  final String achievement;
  final IconData icon;
  final MilestoneStatus status;

  MotivationalMilestone({
    required this.title,
    required this.timeframe,
    required this.motivationQuote,
    required this.encouragement,
    required this.achievement,
    required this.icon,
    required this.status,
  });
}

// Motivational milestones focused on encouragement and inspiration
final List<MotivationalMilestone> motivationalMilestones = [
  MotivationalMilestone(
    title: "The Brave Beginning",
    timeframe: "Weeks 1-2",
    motivationQuote: "Every expert was once a beginner. Every pro was once an amateur. Every icon was once an unknown.",
    encouragement: "You took the first step into the world of law - that takes courage! Building foundations is never glamorous, but it's essential. You're not just learning - you're transforming!",
    achievement: "Foundation Builder - You started strong!",
    icon: Icons.rocket_launch,
    status: MilestoneStatus.completed,
  ),
  
  MotivationalMilestone(
    title: "The Knowledge Warrior",
    timeframe: "Weeks 3-4",
    motivationQuote: "Knowledge is power, but applied knowledge is superpower.",
    encouragement: "You're absorbing complex legal concepts like a sponge! Each case law you read, each principle you master - you're building your legal arsenal. Warriors train daily, and so do you!",
    achievement: "Legal Warrior - Your mind is your weapon!",
    icon: Icons.psychology,
    status: MilestoneStatus.completed,
  ),
  
  MotivationalMilestone(
    title: "The Mountain Climber",
    timeframe: "Weeks 5-6",
    motivationQuote: "The view from the top is worth every difficult step along the way.",
    encouragement: "Property law felt like climbing Everest, didn't it? But you conquered it! You've proven you can tackle the most challenging subjects. You're stronger than you think!",
    achievement: "Peak Conqueror - You scaled the heights!",
    icon: Icons.landscape,
    status: MilestoneStatus.completed,
  ),
  
  MotivationalMilestone(
    title: "🎉 THE CHAMPION MOMENT 🎉",
    timeframe: "End of Week 6",
    motivationQuote: "Success is not final, failure is not fatal: it is the courage to continue that counts.",
    encouragement: "YOU DID IT! Stage 1 is conquered! This wasn't luck - this was preparation meeting opportunity. You've proven you have what it takes. Feel that pride - you've earned it!",
    achievement: "STAGE 1 CHAMPION - You're officially unstoppable!",
    icon: Icons.emoji_events,
    status: MilestoneStatus.completed,
  ),
  
  MotivationalMilestone(
    title: "The Heart of Justice",
    timeframe: "Weeks 7-8",
    motivationQuote: "The law is not just about rules - it's about protecting what matters most to people.",
    encouragement: "Family law touches the deepest parts of human experience. You're not just studying cases - you're preparing to help families, protect children, and honor relationships. Your work has heart!",
    achievement: "Guardian of Families - You're fighting for what matters!",
    icon: Icons.favorite,
    status: MilestoneStatus.current,
  ),
  
  MotivationalMilestone(
    title: "The Justice Seeker",
    timeframe: "Weeks 9-10",
    motivationQuote: "Injustice anywhere is a threat to justice everywhere.",
    encouragement: "Criminal law is where you become a defender of truth! Whether prosecuting or defending, you're ensuring the system works fairly. Every procedure you learn protects someone's rights!",
    achievement: "Truth Defender - Justice flows through you!",
    icon: Icons.balance,
    status: MilestoneStatus.upcoming,
  ),
  
  MotivationalMilestone(
    title: "The Business Builder",
    timeframe: "Weeks 11-12",
    motivationQuote: "In business, legal knowledge isn't just helpful - it's essential for ethical success.",
    encouragement: "Corporate law shapes the business world! You're learning to build companies, protect investors, and ensure fair dealing. You're becoming a guardian of ethical business practices!",
    achievement: "Business Guardian - You build with integrity!",
    icon: Icons.business_center,
    status: MilestoneStatus.upcoming,
  ),
  
  MotivationalMilestone(
    title: "The Courtroom Commander",
    timeframe: "Weeks 13-14",
    motivationQuote: "The courtroom is where preparation meets performance, where justice finds its voice.",
    encouragement: "Litigation skills turn you into a voice for the voiceless! Every procedure you master, every document you draft - you're preparing to stand up and fight for what's right in the halls of justice!",
    achievement: "Courtroom Commander - Your voice carries justice!",
    icon: Icons.gavel,
    status: MilestoneStatus.future,
  ),
  
  MotivationalMilestone(
    title: "The Ethical Leader",
    timeframe: "Weeks 15-16",
    motivationQuote: "Ethics is knowing the difference between what you have a right to do and what is right to do.",
    encouragement: "Professional ethics isn't just about rules - it's about becoming the lawyer people can trust completely. You're joining a noble profession with a sacred duty to serve justice with integrity!",
    achievement: "Ethical Leader - Your integrity lights the way!",
    icon: Icons.verified_user,
    status: MilestoneStatus.future,
  ),
  
  MotivationalMilestone(
    title: "The Final Push",
    timeframe: "Weeks 17-18",
    motivationQuote: "Champions are made when nobody's watching. Excellence is a habit, not an accident.",
    encouragement: "This is your final training montage! Every practice exam, every review session - you're sharpening yourself into the precise legal mind you were meant to become. The finish line is in sight!",
    achievement: "Excellence Achiever - You're ready for anything!",
    icon: Icons.fitness_center,
    status: MilestoneStatus.future,
  ),
  
  MotivationalMilestone(
    title: "🎯 THE ULTIMATE VICTORY 🎯",
    timeframe: "Week 19",
    motivationQuote: "You have been preparing for this moment your entire journey. Trust your preparation, trust yourself.",
    encouragement: "This is it - your moment to shine! You're not just taking an exam, you're claiming your destiny as a legal professional. Every late night, every challenging concept, every moment of doubt - it all led to this triumph!",
    achievement: "LEGAL PROFESSIONAL - You've transformed into who you were meant to be!",
    icon: Icons.workspace_premium,
    status: MilestoneStatus.future,
  ),
];