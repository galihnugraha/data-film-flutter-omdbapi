import 'package:hive/hive.dart';
import '../view/page_bookmarks.dart';
part 'bookmarks.g.dart';

@HiveType(typeId: 0)
class Bookmark extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String released;
  @HiveField(3)
  final String poster;
  Bookmark({
    required this.title,
    required this.released,
    required this.poster,
  });
}
