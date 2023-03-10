import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:weather_app/consts/images.dart';
import 'package:weather_app/consts/string.dart';
import 'package:weather_app/controllers/home_controller.dart';
import 'package:weather_app/models/current_weather_model.dart';
import 'package:weather_app/services/api_services.dart';

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
    var theme = Theme.of(context);
    var controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: "$date"
            .text
            .color(theme.primaryColor)
            .fontFamily("poppins")
            .fontWeight(FontWeight.w400)
            .make(),
        elevation: 0,
        actions: [
          Obx(
            () => IconButton(
                splashColor: Colors.white10,
                onPressed: () {
                  controller.chnageTheme();
                },
                icon: Icon(
                    controller.isdark.value
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    color: controller.isdark.value
                        ? Vx.yellow200
                        : theme.iconTheme.color)),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_rounded,
                color: theme.iconTheme.color,
              ))
        ],
      ),
      body: Container(
          child: FutureBuilder(
              future: controller.currentWeather,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  CurrentWeaherData data = snapshot.data;
                  return VxScrollVertical(
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
                            "${data.name}"
                                .text
                                .uppercase
                                .fontFamily("poppins")
                                .fontWeight(FontWeight.bold)
                                .color(theme.primaryColor)
                                .size(22)
                                .make()
                                .box
                                .alignCenter
                                .padding(EdgeInsets.only(top: height * 0.02))
                                .make(),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: height * 0.04, left: width * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: height * 0.07,
                                foregroundImage:
                                    // AssetImage("assets/images/sun.png"),
                                    NetworkImage("${data.weather[0].icon}"),
                                backgroundColor: Colors.transparent,
                              ),
                              WidthBox(width * 0.02),
                              Container(
                                margin: EdgeInsets.only(top: height * 0.05),
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text:
                                          "${(data.main.temp) ~/ 1}$string${"c"}",
                                      style: TextStyle(
                                          color: theme.primaryColor,
                                          fontFamily: "poppins",
                                          fontSize: 40,
                                          letterSpacing: 2)),
                                  TextSpan(
                                      text: "\t${data.weather[0].main}",
                                      style: TextStyle(
                                          color: theme.primaryColor,
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
                                child: "${(data.main.tempMin) ~/ 1}??c"
                                    .text
                                    .fontFamily("poppins")
                                    .color(theme.primaryColor)
                                    .make()),
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
                                child: "${(data.main.tempMax) ~/ 1}??c"
                                    .text
                                    .fontFamily("poppins")
                                    .color(theme.primaryColor)
                                    .make()),
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
                            var values = [
                              "${data.clouds.all}%",
                              "${data.main.humidity}%",
                              "${data.wind.speed} km/h"
                            ];
                            return Column(
                              children: [
                                Image.asset(
                                  list[index],
                                )
                                    .box
                                    .height(height * 0.08)
                                    .width(width * 0.12)
                                    .make(),
                                "${values[index]}"
                                    .text
                                    .fontFamily("poppins")
                                    .color(theme.primaryColor)
                                    .fontWeight(FontWeight.bold)
                                    .make()
                              ],
                            );
                          }),
                        ),
                        HeightBox(height * 0.02),
                        Divider(
                          color: theme.dividerColor,
                        ),
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
                                      color: controller.isdark.value
                                          ? Vx.gray700
                                          : Vx.blue200,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    children: [
                                      "${index + 1}\tAm"
                                          .text
                                          .fontFamily("poppins")
                                          .color(theme.primaryColor)
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
                                          .color(theme.primaryColor)
                                          .fontWeight(FontWeight.bold)
                                          .make(),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        HeightBox(height * 0.02),
                        Divider(
                          color: theme.dividerColor,
                        ),
                        HeightBox(height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            "Next Days"
                                .text
                                .fontFamily("poppins")
                                .color(theme.primaryColor)
                                .semiBold
                                .size(16)
                                .make(),
                          ],
                        ),
                        ListView.builder(
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              var day = DateFormat("EEEE").format(DateTime.now()
                                  .add(Duration(days: index + 1)));
                              return Card(
                                color: theme.cardColor,
                                shadowColor: Vx.gray700,
                                elevation: 1,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: "$day"
                                              .text
                                              .color(theme.primaryColor)
                                              .semiBold
                                              .make()),
                                      Expanded(
                                        child: Image.asset(
                                          "assets/images/clouds.png",
                                          height: height * 0.022,
                                        ),
                                      ),
                                      "20${string}c"
                                          .text
                                          .fontFamily("poppins")
                                          .color(theme.primaryColor)
                                          .fontWeight(FontWeight.bold)
                                          .make(),
                                      WidthBox(width * 0.08),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "34${string}c\t/",
                                            style: TextStyle(
                                                fontFamily: "poppins",
                                                color: Vx.red600)),
                                        TextSpan(
                                            text: "\t14${string}c",
                                            style: TextStyle(
                                                fontFamily: "poppins",
                                                color: Vx.blue400))
                                      ]))
                                    ],
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}
