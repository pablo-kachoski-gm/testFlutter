import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Hello World', home: RandomWords());
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final Set<WordPair> _saved = Set<WordPair>(); // Add this line.

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[i]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair); // Add this line.

    return Card(
      color: Colors.grey[100],
      child: ExpansionTile(
        leading: Icon(
          Icons.portrait,
          size: 50.0,
        ),
        children: _getExpandableContent(pair.asPascalCase),
        title: Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: IconButton(
          icon: Icon(
            alreadySaved ? Icons.star : Icons.star_border,
            color: alreadySaved ? Colors.yellow : null,
          ),
          onPressed: () => setState(() {
            alreadySaved ? _saved.remove(pair) : _saved.add(pair);
          }),
        ),
      ),
    );
  }

  List<Widget> _getExpandableContent(String textValue) {
    return [
      Row(
        children: [
          Padding(
            padding: EdgeInsets.all(5),
          ),
          Icon(Icons.image, size: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  getSpaceBetweenColumns(),
                  Text('${textValue} 1-1'),
                  getSpaceBetweenColumns(),
                  Text('${textValue} 1-2'),
                  getSpaceBetweenColumns(),
                  Text('${textValue} 1-3'),
                  getSpaceBetweenColumns(),
                  Text('${textValue} 1-4'),
                ],
              ),
              Row(
                children: [
                  getSpaceBetweenColumns(),
                  Text('${textValue} 2-1'),
                  getSpaceBetweenColumns(),
                  Text('${textValue} 2-2'),
                  getSpaceBetweenColumns(),
                  Text('${textValue} 2-3'),
                ],
              ),
            ],
          ),
        ],
      ),
    ];
  }

  Widget getSpaceBetweenColumns() {
    return Padding(
      padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}
