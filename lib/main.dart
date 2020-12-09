import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentTab = 0;

  List<Widget> pageList = List<Widget>();
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageList.add(ColorBoxPage(key: PageStorageKey('pageOne')));
    pageList.add(IncrementState());
    pageList.add(ColorBoxPage(key: PageStorageKey('pageThree')));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    currentTab = index;
    setState(() {});
    pageController.jumpToPage(currentTab);
  }

  void onPageChanged(int index) {
    currentTab = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
          children: pageList,
          controller: pageController,
          onPageChanged: onPageChanged),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.red,
        style: TabStyle.react,
        // cornerRadius: 10.0,
        top: -15.0,
        elevation: 5.0,
        curveSize: 50,
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.map, title: 'Discovery'),
          TabItem(icon: Icons.add, title: 'Add'),
        ],
        initialActiveIndex: 2, //optional, default as 0
        onTap: (int i) => _onItemTapped(i),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: currentTab,
      //   onTap: _onItemTapped,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.people),
      //       label: 'Feed',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Setting',
      //     ),
      //   ],
      // ),
    );
  }
}

class ColorBoxPage extends StatelessWidget {
  ColorBoxPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(10.0),
        child: Material(
          color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}

class IncrementState extends StatefulWidget {
  @override
  _IncrementStateState createState() => _IncrementStateState();
}

class _IncrementStateState extends State<IncrementState>
    with AutomaticKeepAliveClientMixin {
  int _counter = 0;

  void increment() {
    _counter++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_counter.toString(), style: TextStyle(fontSize: 24.0)),
            RaisedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.assistant_navigation),
                label: Text("Navigate"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: increment,
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
