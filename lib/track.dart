import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled1/singal_country.dart';

import 'helper.dart';

class Track extends StatefulWidget {
  const Track({Key? key}) : super(key: key);

  @override
  State<Track> createState() => _TrackState();
}

class _TrackState extends State<Track> {
  TextEditingController searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchControler,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: "Search with name country",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0))),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: stateServices.getCountries(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ));
                      });
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];

                        if (searchControler.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                   SingleContry(name: snapshot.data![index]['country'],
                                     image: snapshot.data![index]['countryInfo']["flag"],
                                     todayRecovered: snapshot.data![index]['recovered'],
                                     critical: snapshot.data![index]['critical'],
                                     avtive:snapshot.data![index]['active'] ,
                                     test: snapshot.data![index]['tests'],
                                     totalCases: snapshot.data![index]['cases'],
                                     totalDathes: snapshot.data![index]['deaths'],
                                     totalRecovered: snapshot.data![index]['recovered'],)
                                  ));

                          },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (name
                            .toUpperCase()
                            .contains(searchControler.text.toUpperCase())) {
                          return Column(
                            children: [
                              InkWell(
                              onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                SingleContry(name: snapshot.data![index]['country'],
                                  image: snapshot.data![index]['countryInfo']["flag"],
                                  todayRecovered: snapshot.data![index]['recovered'],
                                  critical: snapshot.data![index]['critical'],
                                  avtive:snapshot.data![index]['active'] ,
                                  test: snapshot.data![index]['tests'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalDathes: snapshot.data![index]['deaths'],
                                  totalRecovered: snapshot.data![index]['recovered'],)
                            ));

                          },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      });
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
