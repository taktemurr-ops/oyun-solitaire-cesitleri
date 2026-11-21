import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_solitaire_cesitleri/oyun_solitaire_cesitleri.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('100 çeşit, kimlikler benzersiz, 33 dil', () {
    expect(solCesitleri.length, 100);
    expect(solCesitleri.map((c) => c.id).toSet().length, 100);
    expect(solCesitGroup.games.length, 100);
    for (final c in solCesitleri) {
      expect(c.title.length, 33);
      expect(c.title.every((t) => t.isNotEmpty), isTrue);
      for (final s in c.config.tutorial) {
        expect(s.text.length, 33);
      }
    }
  });

  for (final c in solCesitleri) {
    test('${c.id}: dağıtımlar çözücüyle doğrulanır', () {
      final planner = LevelPlanner(gameId: c.id, optionalMechanics: const []);
      for (final lv in [1, 7777]) {
        final sw = Stopwatch()..start();
        final g = c.rules.build(planner.spec(lv));
        // ignore: avoid_print
        print('${c.id} $lv d=${g.spec.difficulty} attempts=${g.attempts} ${sw.elapsedMilliseconds}ms');
        expect(g.attempts < 999, isTrue, reason: '${c.id} $lv çözülemedi');
      }
    });
  }
}
