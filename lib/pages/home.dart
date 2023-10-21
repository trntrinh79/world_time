import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    // var arguments = ModalRoute.of(context)?.settings.arguments;
    // if (arguments is Map<String, dynamic>) {
    //   data = arguments;
    // }
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;
    // print(data);
    String bgImage = 'day.jpeg';
    if (data['isDayTime'] != null) {
      bgImage = data['isDayTime'] ? 'day.jpeg' : 'night.jpeg';
    }
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'].toString(),
                      style: const TextStyle(
                          fontSize: 28, letterSpacing: 1, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                data["time"].toString(),
                style: const TextStyle(fontSize: 66, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        dynamic result =
                            await Navigator.pushNamed((context), '/location');
                        setState(() {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'isDayTime': result['isDayTime'],
                            'flag': result['flag'],
                          };
                        });
                      },
                      icon:
                          const Icon(Icons.edit_location, color: Colors.white),
                      label: const Text(
                        "Edit Location",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
