import 'dart:math';

class RandomIdGenerator {
  static String generateId(){
    const chars =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var rng = Random();
    var autoId = '';
    const targetLength = 28;
    while (autoId.length < targetLength) {
      autoId += chars[rng.nextInt(chars.length)];
    }
    return autoId;
  }
}