import 'dart:math';

class Quotes {
  // TODO : Add quotes here
  static const list = [
    'Ssome quote 1',
    'Ssome quote 2',
    'Ssome quote 3',
    'Ssome quote 4',
  ];

  static String get randomQuote {
    Random r = new Random();
    int i = r.nextInt(100) % Quotes.list.length;
    return Quotes.list[i];
  }
}
