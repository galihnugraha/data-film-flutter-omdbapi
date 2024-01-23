import 'package:path_provider/path_provider.dart';
import 'boxes.dart';
import 'view/page_login.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/bookmarks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(BookmarkAdapter());
  await Hive.openBox<Bookmark>(HiveBoxes.bookmark);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OMDB FILM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.light().copyWith(primary: Colors.tealAccent),
      ),
      home: LoginPage(),
      // home: PageSearchFilm(),
    );
  }
}
