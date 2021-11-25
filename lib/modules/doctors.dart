import '../Controller/Models/DoctorModel/doctor_model.dart';
import '../Controller/static_data.dart';
import '../Widgets/gradient_circular_progress_indicator.dart';
import 'doctor_page.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Doctors extends StatefulWidget {
  final Map<String, dynamic> clinic;

  const Doctors({Key key, this.clinic}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Doctors> {
  List<DoctorModel> searchDoctors = [];

  @override
  void initState() {
    print(widget.clinic);

    searchDoctors = doctors
        .where((element) => element.clinicId == widget.clinic['id'])
        .toList();

    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<DoctorModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = doctors
          .where((element) => element.clinicId == widget.clinic['id'])
          .toList();
    } else {
      results = doctors
          .where((doctor) =>
              doctor.clinicId == widget.clinic['id'] &&
              doctor.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      searchDoctors = results;
    });
  }

  Future<void> fetchDoctors() async {
    // Code for fetching doctors
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Image(
          image: AssetImage('assets/images/bar5.png'),
        ),
        title: Text(
          'اختار الدكتور',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                    labelText: 'البحث', suffixIcon: Icon(Icons.search)),
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: fetchDoctors(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return GradientCircularProgressIndicator(
                        radius: 30,
                        gradientColors: [
                          Color(0xffc0caf7).withOpacity(0.82),
                          Color(0xff051DA4).withOpacity(0.82),
                        ],
                        strokeWidth: 10.0,
                      );
                    } else {
                      return Expanded(
                        child: searchDoctors.length > 0
                            ? ListView.builder(
                                itemCount: searchDoctors.length,
                                itemBuilder: (context, index) => Card(
                                  key: ValueKey(searchDoctors[index].uid),
                                  color: HexColor("#e6e8f5"),
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: ListTile(
                                    leading: Image(
                                      image:
                                          AssetImage('assets/images/bar5.png'),
                                    ),
                                    title: Text(
                                      searchDoctors[index].name,
                                      style: TextStyle(
                                          color: HexColor("#051DA4"),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'عيادة : ${widget.clinic['name']}',
                                          style: TextStyle(
                                              color: HexColor("#051DA4")),
                                        ),
                                        Text(
                                          'التخصص : ${searchDoctors[index].specialization}',
                                          style: TextStyle(
                                              color: HexColor("#051DA4")),
                                        ),
                                      ],
                                    ),
                                    trailing: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DoctorPage(
                                              doctorModel: searchDoctors[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text('احجز'),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.0),
                                                side: BorderSide(
                                                    color:
                                                        Colors.greenAccent))),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.greenAccent),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Text(
                                'No results found',
                                style: TextStyle(fontSize: 24),
                              ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
