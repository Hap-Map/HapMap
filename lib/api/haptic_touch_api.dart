import 'package:flutter_vibrate/flutter_vibrate.dart';

class HapticFeedbackApi {
  static generateFeedback(FeedbackType type) {
    Vibrate.feedback(type);
  }

  static generateFeedbackSequence(List<FeedbackType> feedbackTypes, List<int> intervalDurationsMillis, {int repetitions = 1}) {
    assert (feedbackTypes.length == intervalDurationsMillis.length);

    for (int i = 0; i < feedbackTypes.length; i++) {
      generateFeedback(feedbackTypes[i]);
      Future.delayed(Duration(milliseconds: intervalDurationsMillis[i]));
    }
  }

  static generateLeftFeedback() {
    List<FeedbackType> feedbackTypes = [FeedbackType.selection, FeedbackType.impact];
    List<int> intervalDurationsMillis = [250, 750];
    generateFeedbackSequence(feedbackTypes, intervalDurationsMillis, repetitions: 5);
  }

  static generateRightFeedback() {
    List<FeedbackType> feedbackTypes = [FeedbackType.warning, FeedbackType.heavy];
    List<int> intervalDurationsMillis = [250, 750];
    generateFeedbackSequence(feedbackTypes, intervalDurationsMillis, repetitions: 5);
  }

  static generateDestinationFeedback() {
    List<FeedbackType> feedbackTypes = [FeedbackType.success];
    List<int> intervalDurationsMillis = [250];
    generateFeedbackSequence(feedbackTypes, intervalDurationsMillis, repetitions: 10);
  }
}
