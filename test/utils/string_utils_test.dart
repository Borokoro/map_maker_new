import 'package:flutter_test/flutter_test.dart';
import 'package:map_maker_new/utils/string_utils.dart';

void main() {
  test("removes show less suffix from the end of the text", () {
    expect(StringUtils.removeShowLessSuffix("Działka na sprzedaż.\nTel. 501 676 735 Wyświetl mniej"), "Działka na sprzedaż.\nTel. 501 676 735");
    expect(StringUtils.removeShowLessSuffix("By kupić dom dla naszej rodziny \n Wyświetl mniej\n"), "By kupić dom dla naszej rodziny");
  });

  test("keeps text without the suffix at the end", () {
    expect(StringUtils.removeShowLessSuffix("Wyświetl mniej to nie koniec opisu"), "Wyświetl mniej to nie koniec opisu");
    expect(StringUtils.removeShowLessSuffix("Zwykły opis"), "Zwykły opis");
  });
}
