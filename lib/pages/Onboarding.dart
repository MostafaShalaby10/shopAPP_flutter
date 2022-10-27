import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp1/pages/Login.dart';
import 'package:shopapp1/sharedprefrences/Sharedprefrences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class onboarding extends StatefulWidget {
  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  List images = ["lib/images/1.JPG", "lib/images/2.JPG", "lib/images/3.JPG"];

  var pagecontroller = PageController();

  bool islast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerRight,
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    sharedprefs.savedata(key: "onboarding", value: true) ;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) =>login() ),
                            (route) => false) ;
                  },
                  child: Text(
                    "SKIP",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              Expanded(
                child: Stack(alignment: Alignment.centerRight, children: [
                  PageView.builder(
                    onPageChanged: (int index) {
                      if (index == images.length - 1) {
                        setState(() {
                          islast = true;
                        });
                      } else {
                        setState(() {
                          islast = false;
                        });
                      }
                    },
                    controller: pagecontroller,
                    itemBuilder: (context, index) => Image(
                      image: AssetImage(
                        images[index],
                      ),
                    ),
                    itemCount: images.length,
                  ),
                  IconButton(
                    onPressed: () {
                      sharedprefs.savedata(key: "onboarding", value: true) ;
                      if(islast)
                      {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) =>login() ),
                                (route) => false) ;
                      }else
                      {
                        pagecontroller.nextPage(
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut,

                        );
                      }
                    },
                    icon: Icon(
                      Icons.navigate_next,
                      size: 50,
                    ),
                  )
                ]),
              ),
              Text(
                "Shop App Online",
                style: Theme.of(context).textTheme.bodyText1
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Get your needs online",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: pagecontroller,
                  count: images.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
