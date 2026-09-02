import 'package:easy_localization/easy_localization.dart' hide TextDirection;

/// Translates a fixed English option label (used for genders, categories,
/// colors, seasons, etc. across Home/Categories/Filter/Cart/Details) into
/// the currently selected app language using the `options.*` keys in
/// assets/translations/{en,ar}.json.
///
/// These labels are also used as the raw values stored in Firestore and for
/// matching/filtering logic, so we only translate what's *displayed* here —
/// callers should keep using the original English label for comparisons,
/// storage, and navigation.
///
/// Falls back to the original label untouched if no matching translation
/// key exists, so this is always safe to call even for values coming
/// directly from Firestore that we don't have a translation for yet.
String translateOptionLabel(String label) {
  final trimmed = label.trim();
  if (trimmed.isEmpty) return label;

  final key = trimmed
      .toLowerCase()
      .replaceAll(RegExp(r"[^a-z0-9]+"), '_')
      .replaceAll(RegExp(r'(^_|_$)'), '');
  final translationKey = 'options.$key';
  final translated = translationKey.tr();

  // easy_localization returns the key itself when no translation is found.
  return translated == translationKey ? label : translated;
}
