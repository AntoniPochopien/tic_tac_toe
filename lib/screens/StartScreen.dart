import 'package:flutter/material.dart';
import '../screens/MainScreen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late TextEditingController _xcontroller;
  late TextEditingController _ocontroller;
  List<int> rounds = [1, 3, 5, 10];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _xcontroller = TextEditingController(text: 'PLAYER 1');
    _ocontroller = TextEditingController(text: 'PLAYER 2');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 2,
                  child: Image.asset('lib/assets/images/bg_image.png')),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'x: ',
                            style: TextStyle(fontSize: 40),
                          ),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: Colors.green[700]),
                            child: TextField(
                              textCapitalization: TextCapitalization.characters,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none),
                              controller: _xcontroller,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'o: ',
                            style: TextStyle(fontSize: 40),
                          ),
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                color: Colors.yellow[700]),
                            child: TextField(
                              textCapitalization: TextCapitalization.characters,
                              cursorColor: Colors.black,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none),
                              controller: _ocontroller,
                            ),
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            'UP TO:',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 100,
                              child: ListView.builder(
                                  shrinkWrap: false,
                                  itemCount: rounds.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: ((context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(5),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: selectedIndex == index
                                              ? Colors.pink
                                              : Colors.white,
                                        ),
                                        child: Center(
                                            child: Text(
                                          rounds[index].toString(),
                                          style: TextStyle(
                                              color: selectedIndex == index
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 20,
                                              fontWeight: selectedIndex == index
                                                  ? FontWeight.normal
                                                  : FontWeight.bold),
                                        )),
                                      ),
                                    );
                                  })),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                    child: RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainScreen(
                                rounds[selectedIndex],
                                _xcontroller.text,
                                _ocontroller.text)));
                  },
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: 35.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
