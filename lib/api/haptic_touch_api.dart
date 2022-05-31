import 'dart:async';

import 'package:flutter_vibrate/flutter_vibrate.dart';

enum StepType {
  left,
  right,
  north,
  south,
  destinationReached,
  other
}

class HapticFeedbackApi {
  static _generateFeedback(FeedbackType type) {
    Vibrate.feedback(type);
  }

  static _generateFeedbackSequence(List<FeedbackType> feedbackTypes, List<int> intervalDurationsMillis, {int repetitions = 1}) {
    assert (feedbackTypes.length == intervalDurationsMillis.length);
    assert (repetitions > 0);

    int totalDurationOneRepetition = 0;

    for (int i = 0; i < intervalDurationsMillis.length; i++) {
      totalDurationOneRepetition += intervalDurationsMillis[i];
    }

    Timer.periodic(Duration(milliseconds: totalDurationOneRepetition), (timer) {
      _generateFeedbackFromPosition(feedbackTypes, intervalDurationsMillis);

      repetitions--;
      if (repetitions == 0) {
        timer.cancel();
      }
    });
  }

  static _generateFeedbackFromPosition(List<FeedbackType> feedbackTypes, List<int> intervalDurationsMillis, {int startPosition = 0}) {
    assert (startPosition >= 0);

    _generateFeedback(feedbackTypes[startPosition]);

    if (startPosition < feedbackTypes.length - 1) {
      Timer(Duration(milliseconds: intervalDurationsMillis[startPosition]),
          () => _generateFeedbackFromPosition(feedbackTypes, intervalDurationsMillis, startPosition: startPosition + 1));
    }
  }

  static _generateRightFeedback() {
    List<FeedbackType> feedbackTypes = [FeedbackType.heavy];
    List<int> intervalDurationsMillis = [500];
    _generateFeedbackSequence(feedbackTypes, intervalDurationsMillis, repetitions: 5);
  }

  static _generateNorthFeedback() {
    List<FeedbackType> feedbackTypes = [FeedbackType.heavy, FeedbackType.error];
    List<int> intervalDurationsMillis = [300, 500];
    _generateFeedbackSequence(feedbackTypes, intervalDurationsMillis, repetitions: 5);
  }

  static _generateLeftFeedback() {
    List<FeedbackType> feedbackTypes = [FeedbackType.heavy, FeedbackType.error, FeedbackType.heavy];
    List<int> intervalDurationsMillis = [300, 300, 500];
    _generateFeedbackSequence(feedbackTypes, intervalDurationsMillis, repetitions: 5);
  }

  static _generateSouthFeedback() {
    List<FeedbackType> feedbackTypes = [FeedbackType.heavy, FeedbackType.error, FeedbackType.heavy, FeedbackType.error];
    List<int> intervalDurationsMillis = [300, 300, 300, 500];
    _generateFeedbackSequence(feedbackTypes, intervalDurationsMillis, repetitions: 5);
  }

  static _generateOtherFeedback() {
    List<FeedbackType> feedbackTypes = [FeedbackType.heavy, FeedbackType.heavy];
    List<int> intervalDurationsMillis = [300, 500];
    _generateFeedbackSequence(feedbackTypes, intervalDurationsMillis, repetitions: 3);
  }

  static _generateDestinationFeedback() {
    List<FeedbackType> feedbackTypes = [FeedbackType.error];
    List<int> intervalDurationsMillis = [300];
    _generateFeedbackSequence(feedbackTypes, intervalDurationsMillis, repetitions: 10);
  }

  static generateFeedbackFromStepType(StepType type) {
    if (type == StepType.left) {
      _generateLeftFeedback();
    } else if (type == StepType.right) {
      _generateRightFeedback();
    } else if (type == StepType.north) {
      _generateNorthFeedback();
    } else if (type == StepType.south) {
      _generateSouthFeedback();
    } else if (type == StepType.destinationReached) {
      _generateDestinationFeedback();
    } else if (type == StepType.other) {
      _generateOtherFeedback();
    }
  }
}
