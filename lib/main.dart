import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:map_with_pager/model.dart';
import 'map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GoogleMap With Pager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final control = Get.put(MapController());

  locationList(index) {
    return AnimatedBuilder(
      animation: control.controllerPage,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (control.controllerPage.position.haveDimensions) {
          value = (control.controllerPage.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125,
            width: Curves.easeInOut.transform(value) * 350,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: () {
          control.moveCamera();
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: 125,
                width: 270,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 10)
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            image: DecorationImage(
                                image: NetworkImage(list[index].image),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(list[index].name,style: const TextStyle(
                              fontSize: 12,fontWeight: FontWeight.bold
                            )),
                            Text(list[index].address,maxLines:2,style: const TextStyle(
                                fontSize: 12,fontWeight: FontWeight.w600
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Obx(
        () => Stack(
          children: [
            GoogleMap(
              onMapCreated: control.onmapCreate,
              markers: Set.from(control.markerList),
              initialCameraPosition:
                  const CameraPosition(target: LatLng(0.0, 0.0), zoom: 14),
              myLocationEnabled: true,

              myLocationButtonEnabled: false,
            ),
            Positioned(
                bottom: 20,
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    controller: control.controllerPage,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return locationList(index);
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }


}
