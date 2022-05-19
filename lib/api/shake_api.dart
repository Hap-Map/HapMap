import 'package:shake/shake.dart';

class ShakeApi {
  static final List _onShakeListeners = [];
  static ShakeDetector? _shakeDetector;

  static startOnShakeUpdates() {
    if (_shakeDetector == null) {
      _shakeDetector = ShakeDetector.autoStart(onPhoneShake: () {
        for (Function() onShakeListener in _onShakeListeners) {
          onShakeListener();
        }
      });
    } else {
      _shakeDetector?.startListening();
    }
  }

  static stopOnShakeUpdates() {
    _shakeDetector?.stopListening();
  }

  static addOnShakeListener(Function() onShakeListener) {
    _onShakeListeners.add(onShakeListener);
  }

  static removeOnShakeListener(Function() onShakeListener) {
    if (_onShakeListeners.isNotEmpty) {
      _onShakeListeners.remove(onShakeListener);
    }
  }

  static clearOnShakeListeners() {
    _onShakeListeners.clear();
  }
}
