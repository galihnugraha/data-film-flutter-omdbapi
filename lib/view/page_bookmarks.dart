import '../model/bookmarks.dart';
import '../boxes.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PageBookmarks extends StatefulWidget {
  const PageBookmarks({Key? key}) : super(key: key);

  @override
  _PageBookmarksState createState() => _PageBookmarksState();
}

class _PageBookmarksState extends State<PageBookmarks> {
  void openBoxHive() async {
    await Hive.openBox<Bookmark>(HiveBoxes.bookmark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bookmarked Films"),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<Bookmark>(HiveBoxes.bookmark).listenable(),
          builder: (context, Box<Bookmark> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text('Todo listing is Empty'),
              );
            }
            return _builderFilmsFavorite(context, box);
          },
        )
    );
  }

  Widget _builderFilmsFavorite(BuildContext context, Box box) {
    return Container(
      child: ListView.builder(
        itemCount: box.values.length,
        itemBuilder: (context, index) {
          Bookmark? res = box.getAt(index);
          return Dismissible(
            background: Container(
              color: Colors.red,
            ),
            key: UniqueKey(),
            onDismissed: (direction){
              res!.delete();
            },
            child: _cardFilmsFavorite(res!.title, res.released, res.poster),
          );
        },
      ),
    );
  }

  Widget _cardFilmsFavorite(String title, released, poster) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Image.network(poster),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(title), Text(released)],
          ),
        ],
      ),
    );
  }


}
