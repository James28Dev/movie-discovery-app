import 'package:flutter/material.dart';
import 'package:thanaphat_app_cs/src/pages/config/app_route.dart';
import 'package:thanaphat_app_cs/src/service/network.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // print('index = $_selectedIndex');
      switch (_selectedIndex) {
        case 0:
          Navigator.pushNamed(context, AppRoute.homeRoute);
          break;
        case 1:
          Navigator.pushNamed(context, AppRoute.infoRoute);
          break;
        case 2:
          Navigator.pushNamed(context, AppRoute.upcomingMovieRoute);
          break;
        case 3:
          Navigator.pushNamed(context, AppRoute.myWidgetRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thanaphat App')),
      drawer: CommonDrawer(),
      body: Column(
        children: [
          Image.asset(
            fit: BoxFit.cover,
            width: double.infinity,
            'assets/images/movie_times.jpg',
          ),
          SizedBox(height: 20),
          Text(
            'Movie is comming',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.upcomingMovieRoute);
                },
                child: Container(
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      scale: 8,
                      image: AssetImage('assets/images/cinema.png'),
                    ),
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  width: 90,
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Movie',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.myWidgetRoute);
                },
                child: Container(
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      scale: 8,
                      image: AssetImage('assets/images/newspaper.png'),
                    ),
                    color: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  width: 90,
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'New',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    scale: 8,
                    image: AssetImage('assets/images/map.png'),
                  ),
                  color: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                width: 90,
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Map',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(15),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              crossAxisCount: 3,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, AppRoute.upcomingMovieRoute);
                    NetworkService().getUpcomingMovieDio();
                  },
                  child: buildContainer('Movie', 'assets/images/cinema.png'),
                ),
                GestureDetector(
                  onTap: () {},
                  child: buildContainer('News', 'assets/images/newspaper.png'),
                ),
                GestureDetector(
                  onTap: () {},
                  child: buildContainer('Map', 'assets/images/map.png'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'INFO'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'MOVIE'),
          BottomNavigationBarItem(icon: Icon(Icons.widgets), label: 'MYWIDGET'),
        ],
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.green,
      ),
    );
  }

  Container buildContainer(String name, String imgPath) {
    return Container(
      decoration: ShapeDecoration(
        image: DecorationImage(scale: 8, image: AssetImage(imgPath)),
        color: Colors.blueGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      width: 90,
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/Profile.jpg'),
            ),
            decoration: BoxDecoration(color: Colors.lightGreen),
            accountName: Text(
              'Thanaphat',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              '6642340211@parichat.skru.ac.th',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.deepOrange),
            title: Text('Home'),
            onTap: () {
              // print('info');
              Navigator.pushNamed(context, AppRoute.homeRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.deepOrange),
            title: Text('My Info'),
            onTap: () {
              // print('info');
              Navigator.pushNamed(context, AppRoute.infoRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.movie, color: Colors.pink),
            title: Text('Movie'),
            onTap: () {
              // print('movie');
              Navigator.pushNamed(context, AppRoute.upcomingMovieRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.widgets, color: Colors.deepOrange),
            title: Text('My widget'),
            onTap: () {
              Navigator.pushNamed(context, AppRoute.myWidgetRoute);
            },
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.black),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
