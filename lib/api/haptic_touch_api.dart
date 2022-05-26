import 'package:flutter_vibrate/flutter_vibrate.dart';

class HapticFeedbackApi {
  static generateFeedback(FeedbackType type) {
    Vibrate.feedback(type);
  }
}
