import 'dart:math';

class Quotes {
  static const list = [
    'It is health that is real wealth and not pieces of gold and silver',
    'He who has health has hope; and he who has hope has everything.',
    'It is exercise alone that supports the spirits, and keeps the mind in vigor',
    'Keep your vitality. A life without health is like a river without water.',
    'Three things in life – your health, your mission, and the people you love. That’s it.',
    'A fit body, a calm mind, a house full of love. These things cannot be bought – they must be earned',
    'Happiness is the highest form of health.',
    'A good laugh and a long sleep are the best cures in the doctor’s book.',
    'Man needs difficulties; they are necessary for health',
    "The more you understand yourself, the more silence there is, the healthier you are",
    'The greatest of follies is to sacrifice health for any other kind of happiness.',
    'What is called genius is the abundance of life and health.',
    'The greatest wealth is health.',
    'Let food be thy medicine and medicine be thy food.',
    'Health is a vehicle, not a destination.',
    'When the heart is at ease, the body is healthy.',
    'Good health and good sense are two of life’s greatest blessings',
    "Before healing others, heal yourself.",
    'I believe that the greatest gift you can give your family and the world is a healthy you',
    'It is no measure of health to be well adjusted to a profoundly sick society.',
    "Good humor is the health of the soul, sadness is its poison.",
    'Sickness – nature’s vengeance for violating her laws',
  ];

  static String get randomQuote {
    Random r = new Random();
    int i = r.nextInt(100) % Quotes.list.length;
    return Quotes.list[i];
  }
}
