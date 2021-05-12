import 'package:crescendo_hack/essentials/slider.dart';
import 'package:crescendo_hack/essentials/themecolor.dart';
import 'package:crescendo_hack/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GetStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
      },
      home: GetStarted(),
    );
  }
}

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  int _currentPage = 0;
  PageController _controller = PageController();

  List<Widget> _pages = [
    SliderPage(
        title: "Get your desired Recipes",
        description:
        "Just enter the ingredients and voila!",
        image: "images/getstarted1.jpeg"),
    SliderPage(
        title: "Nutrition Tracking",
        description:
        "Keep track of the nutritional values and nutrition intake per meal and the time of meal",
        image: "images/getstarted2.jpeg"),
    SliderPage(
        title: "Recommendation by taste",
        description:
        "Recommendations on your desired dishes for the next meal of the day with suggested time of consumption",
        image: "images/getstarted3.jpeg"),
  ];

  _onchanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Stack(
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.horizontal,
                onPageChanged: _onchanged,
                controller: _controller,
                itemCount: _pages.length,
                itemBuilder: (context, int index) {
                  return _pages[index];
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(_pages.length, (int index) {
                        return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: 10,
                            width: (index == _currentPage) ? 30 : 10,
                            margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: (index == _currentPage)
                                    ? kThemeColor
                                    : kThemeColor.withOpacity(0.5)));
                      })),
                  InkWell(
                    onTap: () {
                      _controller.nextPage(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeInOutQuint);
                    },
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      duration: Duration(milliseconds: 300),
                      height: 70,
                      width: (_currentPage == (_pages.length - 1)) ? 200 : 75,
                      decoration: BoxDecoration(
                          color: kThemeColor,
                          borderRadius: BorderRadius.circular(35)),
                      child: (_currentPage == (_pages.length - 1))
                          ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login()));
                        },
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      )
                          : Icon(
                        Icons.navigate_next,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ],
          ),
        )
    );
  }
}