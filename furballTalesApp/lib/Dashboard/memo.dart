import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './memo_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../frontend_settings.dart';

var baseColor = NeumorphicCardSettings.baseColor;

var caveIntensity = NeumorphicCaveSettings.caveIntensity;
var caveDepth = NeumorphicCaveSettings.caveDepth;
var caveColor = NeumorphicCaveSettings.caveColor;

class MemoList extends StatefulWidget {
  @override
  MemoListState createState() => MemoListState();
}

class MemoListState extends State<MemoList> {
  var _memoList = new List<String>();
  var _currentIndex = -1;
  bool _loading = true;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    this.loadMemoList();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(body: CircularProgressIndicator());
    }
    return Scaffold(
      body: _buildList(),
      backgroundColor: Color(baseColor),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMemo,
        tooltip: 'New Memo',
        backgroundColor: Colors.transparent,
        child: NeumorphicIcon(
          Icons.add_circle,
          size: 60,
        ),
      ),
    );
  }

  void loadMemoList() {
    SharedPreferences.getInstance().then((prefs) {
      const key = "memo-list";
      if (prefs.containsKey(key)) {
        _memoList = prefs.getStringList(key);
      }
      setState(() {
        _loading = false;
      });
    });
  }

  void _addMemo() {
    setState(() {
      _memoList.add("");
      _currentIndex = _memoList.length - 1;
      storeMemoList();
      Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new MemoEdit(_memoList[_currentIndex], _onChanged);
        },
      ));
    });
  }

  void _onChanged(String text) {
    setState(() {
      _memoList[_currentIndex] = text;
      storeMemoList();
    });
  }

  void storeMemoList() async {
    final prefs = await SharedPreferences.getInstance();
    const key = "memo-list";
    final success = await prefs.setStringList(key, _memoList);
    if (!success) {
      debugPrint("Failed to store value");
    }
  }

  Widget _buildList() {
    final itemCount = _memoList.length == 0 ? 0 : _memoList.length * 2 - 1;
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: itemCount,
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(height: 2);
          final index = (i / 2).floor();
          final memo = _memoList[index];
          return _buildWrappedRow(memo, index);
        });
  }

  Widget _buildWrappedRow(String content, int index) {
    return Dismissible(
      background: Container(color: Colors.red),
      key: Key(content),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          _memoList.removeAt(index);
          storeMemoList();
        });
      },
      child: _buildRow(content, index),
    );
  }

  Widget _buildRow(String content, int index) {
    return ListTile(
      title: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          // boxShape: NeumorphicBoxShape.roundRect(
          //     borderRadius: BorderRadius.circular(12)),
          depth: caveDepth,
          intensity: caveIntensity,
          lightSource: LightSource.topLeft,
          color: Color(caveColor),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            content,
            style: TextStyle(height: 1.5, fontSize: 15),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onTap: () {
        _currentIndex = index;
        Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (BuildContext context) {
          return new MemoEdit(_memoList[_currentIndex], _onChanged);
        }));
      },
    );
  }
}
