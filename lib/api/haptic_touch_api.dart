import 'package:flutter_vibrate/flutter_vibrate.dart';

class HapticFeedbackApi {
  static generateFeedback(FeedbackType type) {
    Vibrate.feedback(type);
  }

  static generateFeedbackSequence(List intervalDurations, List feedbackTypes) {
    // TODO: Generate multiple feedbacks in a series of durations.
  }
}
