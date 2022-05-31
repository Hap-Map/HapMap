import 'package:flutter_vibrate/flutter_vibrate.dart';

class VibrateApi {
  static generateRightFeedback() {
    final Iterable<Duration> pauses = [
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 500)
    ];

    Vibrate.vibrateWithPauses(pauses);
  }

  static generateNorthFeedback() {
    final Iterable<Duration> pauses = [
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 300)
    ];

    Vibrate.vibrateWithPauses(pauses);
  }

  static generateLeftFeedback() {
    final Iterable<Duration> pauses = [
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300)
    ];

    Vibrate.vibrateWithPauses(pauses);
  }

  static generateSouthFeedback() {
    final Iterable<Duration> pauses = [
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300)
    ];

    Vibrate.vibrateWithPauses(pauses);
  }

  static generateOtherFeedback() {
    final Iterable<Duration> pauses = [
      const Duration(milliseconds: 400),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 400),
      const Duration(milliseconds: 500),
      const Duration(milliseconds: 400)
    ];

    Vibrate.vibrateWithPauses(pauses);
  }

  static generateDestinationFeedback() {
    final Iterable<Duration> pauses = [
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300)
    ];

    Vibrate.vibrateWithPauses(pauses);
  }
}
