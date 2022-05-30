import 'package:flutter_vibrate/flutter_vibrate.dart';

class HapticFeedbackApi {
  static generateFeedback(FeedbackType type) {
    Vibrate.feedback(type);
  }

  static generateFeedbackSequence(List feedbackTypes, List intervalDurationsMillis, {int repetitions = 1}) {
    assert (feedbackTypes.length == intervalDurationsMillis.length);

    for (int i = 0; i < feedbackTypes.length; i++) {
      generateFeedback(feedbackTypes[i]);
      Future.delayed(Duration(milliseconds: intervalDurationsMillis[i]));
    }
  }
}
