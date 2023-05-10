import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Home View'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Open PDF',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  controller.openFile();
                },
                splashColor: Colors.white,
                child: Ink(
                  height: 40,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.picture_as_pdf,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5,),
                      Center(
                        child: Text(
                          'Open',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ),
                    ],
                  ),
                ) 
              )
            ],
          )
        ),
      )
    );
  }
}
