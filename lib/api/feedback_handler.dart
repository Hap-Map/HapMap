import 'package:hap_map/api/haptic_feedback_api.dart';
import 'package:hap_map/api/vibrate_api.dart';

enum StepType {
  left,
  right,
  north,
  south,
  destinationReached,
  other
}

enum UserFeedback {
  vibrate,
  hapticTouch
}

class FeedbackHandlerApi {
  static generateFeedbackFromStepType(StepType stepType, UserFeedback feedback) {
    if (feedback == UserFeedback.hapticTouch) {
      if (stepType == StepType.left) {
        HapticFeedbackApi.generateLeftFeedback();
      } else if (stepType == StepType.right) {
        HapticFeedbackApi.generateRightFeedback();
      } else if (stepType == StepType.north) {
        HapticFeedbackApi.generateNorthFeedback();
      } else if (stepType == StepType.south) {
        HapticFeedbackApi.generateSouthFeedback();
      } else if (stepType == StepType.destinationReached) {
        HapticFeedbackApi.generateDestinationFeedback();
      } else if (stepType == StepType.other) {
        HapticFeedbackApi.generateOtherFeedback();
      }
    } else if (feedback == UserFeedback.vibrate) {
      if (stepType == StepType.left) {
        VibrateApi.generateLeftFeedback();
      } else if (stepType == StepType.right) {
        VibrateApi.generateRightFeedback();
      } else if (stepType == StepType.north) {
        VibrateApi.generateNorthFeedback();
      } else if (stepType == StepType.south) {
        VibrateApi.generateSouthFeedback();
      } else if (stepType == StepType.destinationReached) {
        VibrateApi.generateDestinationFeedback();
      } else if (stepType == StepType.other) {
        VibrateApi.generateOtherFeedback();
      }
    }
  }
}
