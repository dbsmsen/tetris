import 'package:flutter/material.dart';
import 'package:tetris/board.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.black,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Builder(
                builder: (context) =>IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white, size: 50.0),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Welcome,',
                style: TextStyle(
                  fontFamily: 'RobotoSlab',
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.not_started, color: Colors.white, size: 24),
              title: const Text(
                'New Game',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.leaderboard, color: Colors.white, size: 24),
              title: const Text(
                'Leaderboard',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tour_rounded, color: Colors.white, size: 24),
              title: const Text(
                'Tourament',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white, size: 24),
              title: const Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.details ,color: Colors.white, size: 24),
              title: const Text(
                'About',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.white, size: 24),
              title: const Text(
                'Exit',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tetris.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 220.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GameBoard()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black12,
                      textStyle: const TextStyle(fontSize: 40.0),
                      padding: const EdgeInsets.all(12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      side: const BorderSide(
                        color: Colors.yellow,
                        width: 2,
                      )
                    ),
                    child: const Text(
                      'START',
                      style: TextStyle(
                        fontFamily: 'Sixtyfour',
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
