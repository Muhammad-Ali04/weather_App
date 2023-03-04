import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:weather_app/consts/images.dart';
import 'package:weather_app/consts/string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var date = DateFormat("yMMMMd").format(DateTime.now());
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Vx.blue100,
      appBar: AppBar(
        backgroundColor: Vx.blue100,
        title: "$date"
            .text
            .color(Vx.black)
            .fontFamily("poppins")
            .fontWeight(FontWeight.w400)
            .make(),
        elevation: 0,
        actions: [
          IconButton(
              splashColor: Colors.white10,
              onPressed: () {},
              icon: Icon(
                Icons.light_mode_rounded,
                color: Vx.yellow600,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_rounded,
                color: Vx.black,
              ))
        ],
      ),
      body: Container(
        child: VxScrollVertical(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: height * 0.02),
                    child: Icon(
                      Icons.location_on,
                      color: Vx.red800,
                    ),
                  ),
                  "Rahim Yar Khan"
                      .text
                      .fontFamily("poppins")
                      .fontWeight(FontWeight.bold)
                      .color(Vx.black)
                      .size(22)
                      .make()
                      .box
                      .alignCenter
                      .padding(EdgeInsets.only(top: height * 0.02))
                      .make(),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.04, left: width * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: height * 0.07,
                      foregroundImage: AssetImage("assets/images/sun.png"),
                      backgroundColor: Colors.transparent,
                    ),
                    WidthBox(width * 0.02),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.05),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "37°",
                            style: TextStyle(
                                color: Vx.black,
                                fontFamily: "poppins",
                                fontSize: 40,
                                letterSpacing: 2)),
                        TextSpan(
                            text: "Hot",
                            style: TextStyle(
                                color: Vx.black,
                                fontFamily: "poppins",
                                fontSize: 16,
                                letterSpacing: 3))
                      ])),
                    ),
                  ],
                ),
              ),
              HeightBox(height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: height * 0.03),
                      child: "12°c".text.fontFamily("poppins").make()),
                  Container(
                    child: Image.asset(
                      "assets/images/low_temp.png",
                      height: height * 0.06,
                      width: width * 0.06,
                    ),
                  ),
                  WidthBox(width * 0.035),
                  Container(
                      margin: EdgeInsets.only(top: height * 0.03),
                      child: "42°c".text.fontFamily("poppins").make()),
                  Container(
                    child: Image.asset(
                      "assets/images/hot_temp.png",
                      height: height * 0.06,
                      width: width * 0.06,
                    ),
                  )
                ],
              ),
              HeightBox(height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  var list = [clouds, humidity, windSpeed];
                  var values = ["65%", "10%", "12 km/h"];
                  return Column(
                    children: [
                      Image.asset(
                        list[index],
                      ).box.height(height * 0.08).width(width * 0.12).make(),
                      "${values[index]}"
                          .text
                          .fontFamily("poppins")
                          .fontWeight(FontWeight.bold)
                          .make()
                    ],
                  );
                }),
              ),
              HeightBox(height * 0.02),
              Divider(),
              HeightBox(height * 0.02),
              SizedBox(
                height: height * 0.15,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        padding: EdgeInsets.all(width * 0.02),
                        margin: EdgeInsets.only(right: width * 0.02),
                        decoration: BoxDecoration(
                            color: Vx.blue200,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            "${index + 1}\tAm"
                                .text
                                .fontFamily("poppins")
                                .fontWeight(FontWeight.bold)
                                .make(),
                            HeightBox(height * 0.01),
                            Image.asset(
                              "assets/images/clouds.png",
                              fit: BoxFit.fill,
                              height: height * 0.045,
                            ),
                            HeightBox(height * 0.02),
                            "20${string}c"
                                .text
                                .fontFamily("poppins")
                                .fontWeight(FontWeight.bold)
                                .make(),
                          ],
                        ),
                      );
                    }),
              ),
              HeightBox(height * 0.02),
              Divider(),
              HeightBox(height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  "Next Days"
                      .text
                      .fontFamily("poppins")
                      .semiBold
                      .size(16)
                      .make(),
                ],
              ),
              ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    var day = DateFormat("EEEE")
                        .format(DateTime.now().add(Duration(days: index + 1)));
                    return Card(
                      color: Vx.blue200,
                      shadowColor: Vx.gray700,
                      elevation: 1,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: "$day".text.semiBold.make()),
                            Expanded(
                              child: Image.asset(
                                "assets/images/clouds.png",
                                height: height * 0.022,
                              ),
                            ),
                            "20${string}c"
                                .text
                                .fontFamily("poppins")
                                .fontWeight(FontWeight.bold)
                                .make(),
                            WidthBox(width * 0.08),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "34${string}c\t/",
                                  style: TextStyle(
                                      fontFamily: "poppins", color: Vx.red600)),
                              TextSpan(
                                  text: "\t14${string}c",
                                  style: TextStyle(
                                      fontFamily: "poppins", color: Vx.blue400))
                            ]))
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
