import 'package:flutter/material.dart';

enum MilestoneStatus {
  completed,
  current,
  upcoming,
  future
}

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

final List<MotivationalMilestone> motivationalMilestones = [
  MotivationalMilestone(
    title: "The Brave Beginning",
    timeframe: "Week 1",
    motivationQuote: "Every expert was once a beginner. Every pro was once an amateur. Every icon was once an unknown.",
    encouragement: "You took the first step into the world of law - that takes courage! Building foundations is never glamorous, but it's essential. You're not just learning - you're transforming!",
    achievement: "Foundation Builder - You started strong!",
    icon: Icons.rocket_launch,
    status: MilestoneStatus.completed,
  ),
  
  MotivationalMilestone(
    title: "The Knowledge Warrior",
    timeframe: "Week 2",
    motivationQuote: "Knowledge is power, but applied knowledge is superpower.",
    encouragement: "You're absorbing complex legal concepts like a sponge! Each case law you read, each principle you master - you're building your legal arsenal. Warriors train daily, and so do you!",
    achievement: "Legal Warrior - Your mind is your weapon!",
    icon: Icons.psychology,
    status: MilestoneStatus.completed,
  ),
  
  MotivationalMilestone(
    title: "The Mountain Climber",
    timeframe: "Week 3",
    motivationQuote: "The view from the top is worth every difficult step along the way.",
    encouragement: "Property law felt like climbing Everest, didn't it? But you conquered it! You've proven you can tackle the most challenging subjects. You're stronger than you think!",
    achievement: "Peak Conqueror - You scaled the heights!",
    icon: Icons.landscape,
    status: MilestoneStatus.completed,
  ),
  
  MotivationalMilestone(
    title: "🎉 THE CHAMPION MOMENT 🎉",
    timeframe: "Week 4",
    motivationQuote: "Success is not final, failure is not fatal: it is the courage to continue that counts.",
    encouragement: "YOU DID IT! Stage 1 is conquered! This wasn't luck - this was preparation meeting opportunity. You've proven you have what it takes. Feel that pride - you've earned it!",
    achievement: "STAGE 1 CHAMPION - You're officially unstoppable!",
    icon: Icons.emoji_events,
    status: MilestoneStatus.completed,
  ),
  
  MotivationalMilestone(
    title: "The Heart of Justice",
    timeframe: "Week 5",
    motivationQuote: "The law is not just about rules - it's about protecting what matters most to people.",
    encouragement: "Family law touches the deepest parts of human experience. You're not just studying cases - you're preparing to help families, protect children, and honor relationships. Your work has heart!",
    achievement: "Guardian of Families - You're fighting for what matters!",
    icon: Icons.favorite,
    status: MilestoneStatus.current,
  ),
  
  MotivationalMilestone(
    title: "The Justice Seeker",
    timeframe: "Week 6",
    motivationQuote: "Injustice anywhere is a threat to justice everywhere.",
    encouragement: "Criminal law is where you become a defender of truth! Whether prosecuting or defending, you're ensuring the system works fairly. Every procedure you learn protects someone's rights!",
    achievement: "Truth Defender - Justice flows through you!",
    icon: Icons.balance,
    status: MilestoneStatus.upcoming,
  ),
  
  MotivationalMilestone(
    title: "The Business Builder",
    timeframe: "Week 7",
    motivationQuote: "In business, legal knowledge isn't just helpful - it's essential for ethical success.",
    encouragement: "Corporate law shapes the business world! You're learning to build companies, protect investors, and ensure fair dealing. You're becoming a guardian of ethical business practices!",
    achievement: "Business Guardian - You build with integrity!",
    icon: Icons.business_center,
    status: MilestoneStatus.upcoming,
  ),
  
  MotivationalMilestone(
    title: "The Courtroom Commander",
    timeframe: "Last 3 days!",
    motivationQuote: "The courtroom is where preparation meets performance, where justice finds its voice.",
    encouragement: "Litigation skills turn you into a voice for the voiceless! Every procedure you master, every document you draft - you're preparing to stand up and fight for what's right in the halls of justice!",
    achievement: "Courtroom Commander - Your voice carries justice!",
    icon: Icons.gavel,
    status: MilestoneStatus.future,
  ),
  
  MotivationalMilestone(
    title: "The Ethical Leader",
    timeframe: "Last 2 days!",
    motivationQuote: "Ethics is knowing the difference between what you have a right to do and what is right to do.",
    encouragement: "Professional ethics isn't just about rules - it's about becoming the lawyer people can trust completely. You're joining a noble profession with a sacred duty to serve justice with integrity!",
    achievement: "Ethical Leader - Your integrity lights the way!",
    icon: Icons.verified_user,
    status: MilestoneStatus.future,
  ),
  
  MotivationalMilestone(
    title: "The Final Push",
    timeframe: "It's the day!!",
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