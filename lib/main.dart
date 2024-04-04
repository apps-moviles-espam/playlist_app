import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListViewDemoPage(),
    );
  }
}

class ListViewDemoPage extends StatelessWidget {
  ListViewDemoPage({Key? key}) : super(key: key);

  // This is our model. In this example it's hardcoded (only for demo purposes).
  final songs = [
    Song(trackNumber: 1, title: 'I Saw Her Standing There'),
    Song(trackNumber: 2, title: 'Misery'),
    Song(trackNumber: 3, title: 'Anna (Go to Him)'),
    Song(trackNumber: 4, title: 'Chains'),
    Song(trackNumber: 5, title: 'Boys'),
    Song(trackNumber: 6, title: 'Ask Me Why'),
    Song(trackNumber: 7, title: 'Please Please Me'),
  ];

  // When user double taps on any song, we want to do something. In this case, just print
  // its title (check debug console). Please note this function gets a Song object from
  // the SongWidget. So, the workflow is as follows: 1) ListView creates many SongWidget
  // objects and gives a Song object to each of them; 2) each SongWidget does what it
  // wants with the Song object it gets; 3) when user double taps on a SongWidget, it
  // executes the function it's been passed as a parameter. This last step is important:
  // SongWidget has two parameters: a Song object and a Function. The Song object is the
  // data it needs in order to show some texts, etc. The Function is just that, a function.
  // The SongWidget may decide not to do anything with it. But it may also decide to call
  // it (to execute it) at some time.
  // You may be thinking... why don't we just print this song's title from the widget
  // itself and then we don't need this function at all? And that's correct. But in many
  // cases you will need to do something with the model (the songs list). And you don't
  // have access to it from SongWidget (and you SHOULD NOT HAVE ACCESS TO IT FROM THERE).
  // So the widget's responsability is just to inform when user double taps on it, so that
  // some other part of our application can do whatever it needs.
  void doSomething(Song song) {
    // ignore: avoid_print
    print(song.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView & GestureDetector Demo'),
      ),
      body: ListView(
        children: songs
            .map((song) => SongWidget(song: song, onDoubleTap: doSomething))
            .toList(),
      ),
    );
  }
}

// This should be in its own file, of course. It's here just for demo purposes.
class Song {
  final int trackNumber;
  final String title;

  Song({required this.trackNumber, required this.title});
}

// This should be in its own file, of course. It's here just for demo purposes.
class SongWidget extends StatelessWidget {
  final Song song;
  final Function onDoubleTap;

  const SongWidget({Key? key, required this.song, required this.onDoubleTap})
      : super(key: key);

  // Read comments in order 1-2-3 please.
  @override
  Widget build(BuildContext context) {
    // 3 - Finally, as we want our widget to be able to respond to some gestures, we wrap
    // everything using a GestureDetector widget. In this cas we only use the double tap
    // gesture, but we could add more properties to detect more gestures using this same
    // GestureDetector, no need to add new widgets.
    return GestureDetector(
      onDoubleTap: () {
        onDoubleTap(song);
      },
      // 2 - As we want some free space around texts, we wrap the Column widget with this
      // Padding widget. Its sole purpose is to add some padding around Column.
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        // 1 - Column is actually "main" widget in this build() method. We want to show
        // two strings and use a Column for that. Nothing new here, nothing fancy.
        child: Column(
          children: [
            Text(song.trackNumber.toString()),
            Text(song.title),
          ],
        ),
      ),
    );
  }
}
