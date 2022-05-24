import 'package:flutter_vibrate/flutter_vibrate.dart';

class HapticFeedbackApi {
  static generate(FeedbackType type) {
    Vibrate.feedback(type);
  }
}
