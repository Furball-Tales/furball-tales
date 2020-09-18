import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'app_bar.dart';
import 'homepage.dart';

class TutorialSlider extends StatefulWidget {
  String __nextView;

  TutorialSlider(String nextView) {
    this.__nextView = nextView;
  }

  @override
  State<StatefulWidget> createState() {
    return _TutorialSlider();
  }
}

class _TutorialSlider extends State<TutorialSlider> {
  // 1 Step: Create List of Slides
  List<Slide> slides = new List();

  // 2 Step: Create goToTab function
  Function goToTab;

  // 3 Step: Initialize Images
  @override
  void initState() {
    super.initState();

    slides.add(new Slide(
      title: "Welcome to Furball Tales",
      styleTitle: TextStyle(
          color: Colors.black87,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoMono'),
      description:
          "Here's a quick tutorial so you can navigate through the App with ease...",
      styleDescription: TextStyle(
          color: Color(0xff3da4ab),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontFamily: 'Raleway'),
      pathImage: "assets/logo.png",
      backgroundImage: "assets/profile_background.png",
      backgroundOpacity: 0.0,
    ));
    slides.add(
      new Slide(
        title: "Dashboard/Home page",
        styleTitle: TextStyle(
            color: Colors.black87,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Here, you can see your registered pets. To add more of your pets, click the plus in the top right corner.\nYou can also navigate through the app via the bottom Navigation Bar.",
        styleDescription: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/dashboard_1.png",
        heightImage: 400.0,
        backgroundImage: "assets/profile_background.png",
        backgroundOpacity: 0.0,
      ),
    );
    slides.add(
      new Slide(
        title: "Albums/Photos page",
        styleTitle: TextStyle(
            color: Colors.black87,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Here, you can see albums and pictures. You can create a new album/photo by clicking the plus button.\nIn this part of the app, if you long press an album/picture, you can delete it",
        styleDescription: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/albums_1.png",
        heightImage: 400.0,
        backgroundImage: "assets/profile_background.png",
        backgroundOpacity: 0.0,
      ),
    );
    slides.add(
      new Slide(
        title: "Calendar page",
        styleTitle: TextStyle(
            color: Colors.black87,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Here, can create/update/delete calendar events for your pet's needs. Good luck exploring!",
        styleDescription: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/calendar_1.png",
        heightImage: 400.0,
        backgroundImage: "assets/profile_background.png",
        backgroundOpacity: 0.0,
      ),
    );
    slides.add(
      new Slide(
        title: "Medical/Vet page",
        styleTitle: TextStyle(
            color: Colors.black87,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "This is where you can add all your pets medical info after visiting the vet.\nIt's a great way to keep track of all your visits!",
        styleDescription: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/medical_1.png",
        heightImage: 400.0,
        backgroundImage: "assets/profile_background.png",
        backgroundOpacity: 0.0,
      ),
    );
    slides.add(
      new Slide(
        title: "Profile page",
        styleTitle: TextStyle(
            color: Colors.black87,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "This is where you can see all about the app, the developers and an option to logout.\nWe hope you enjoy using our one stop app for your pets!",
        styleDescription: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/profile_1.png",
        heightImage: 400.0,
        backgroundImage: "assets/profile_background.png",
        backgroundOpacity: 0.0,
      ),
    );
  }

  // 4 Step: Create Other functions
  void onDonePress() {
    if (widget.__nextView == "Tutorial") {
      Navigator.pop(context);
    } else {
      Homepage();
    }
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xffffcc5c),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }

  // 5 Step: Custom Tabs

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 700.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        "Donation",
        'back',
      ),
      body: IntroSlider(
        // List slides
        slides: this.slides,

        // Skip button
        renderSkipBtn: this.renderSkipBtn(),
        colorSkipBtn: Color(0x33ffcc5c),
        highlightColorSkipBtn: Color(0xffffcc5c),

        // Next button
        renderNextBtn: this.renderNextBtn(),

        // Done button
        renderDoneBtn: this.renderDoneBtn(),
        onDonePress: this.onDonePress,
        colorDoneBtn: Color(0x33ffcc5c),
        highlightColorDoneBtn: Color(0xffffcc5c),

        // Dot indicator
        colorDot: Color(0xffffcc5c),
        sizeDot: 13.0,

        // Tabs
        // listCustomTabs: this.renderListCustomTabs(),
        backgroundColorAllSlides: Colors.white,
        refFuncGoToTab: (refFunc) {
          this.goToTab = refFunc;
        },

        // Show or hide status bar
        shouldHideStatusBar: true,

        // On tab change completed
        onTabChangeCompleted: this.onTabChangeCompleted,
      ),
    );
  }
}
