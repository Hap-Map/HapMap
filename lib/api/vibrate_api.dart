import 'dart:async';

import 'package:flutter_vibrate/flutter_vibrate.dart';

class VibrateApi {
  static _generateFeedbackSequence(List<int> intervalDurationsMillis, {int repetitions = 1}) {
    assert (repetitions > 0);

    int totalDurationOneRepetition = 0;

    for (int i = 0; i < intervalDurationsMillis.length; i++) {
      totalDurationOneRepetition += intervalDurationsMillis[i];
    }

    Timer.periodic(Duration(milliseconds: totalDurationOneRepetition), (timer) {
      _generateFeedbackFromPosition(intervalDurationsMillis);

      repetitions--;
      if (repetitions == 0) {
        timer.cancel();
      }
    });
  }

  static _generateFeedbackFromPosition(List<int> intervalDurationsMillis, {int startPosition = 0}) {
    assert (startPosition >= 0);

    Vibrate.vibrate();

    if (startPosition < intervalDurationsMillis.length - 1) {
      Timer(Duration(milliseconds: intervalDurationsMillis[startPosition]),
              () => _generateFeedbackFromPosition(intervalDurationsMillis, startPosition: startPosition + 1));
    }
  }

  static generateRightFeedback() {
    List<int> intervalDurationsMillis = [1000];
    _generateFeedbackSequence(intervalDurationsMillis, repetitions: 5);
  }

  static generateNorthFeedback() {
    List<int> intervalDurationsMillis = [600, 1000];
    _generateFeedbackSequence(intervalDurationsMillis, repetitions: 5);
  }

  static generateLeftFeedback() {
    List<int> intervalDurationsMillis = [600, 600, 1000];
    _generateFeedbackSequence(intervalDurationsMillis, repetitions: 5);
  }

  static generateSouthFeedback() {
    List<int> intervalDurationsMillis = [600, 600, 600, 1000];
    _generateFeedbackSequence(intervalDurationsMillis, repetitions: 5);
  }

  static generateOtherFeedback() {
    List<int> intervalDurationsMillis = [800, 1000];
    _generateFeedbackSequence(intervalDurationsMillis, repetitions: 3);
  }

  static generateDestinationFeedback() {
    List<int> intervalDurationsMillis = [600];
    _generateFeedbackSequence(intervalDurationsMillis, repetitions: 10);
  }
}
