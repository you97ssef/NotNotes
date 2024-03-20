import 'dart:math';

class Util {
  static String randomString(int length) {
    const chars = '1234567890abcdefghijklmnopqrstuvwxyz';
    final rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(
          rnd.nextInt(chars.length),
        ),
      ),
    );
  }
}
