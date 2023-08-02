import 'package:hive/hive.dart';

class RecentSearchListLocalDatasource {
  static const _boxName = 'recent_search_items';

  Box<String>? _box;

  Future<void> _openBox() async {
    _box ??= await Hive.openBox<String>(_boxName);
  }

  Future<List<String>> getAll() async {
    await _openBox();

    return _box!.values.toList();
  }

  Future<void> add(String searchText) async {
    await _box?.add(searchText);
  }

  Future<void> delete(int index) async {
    await _box?.deleteAt(index);
  }
}
