import 'package:flutter/material.dart';
import 'package:mahindra_finance_task/models/user_details.dart';

class WeekContents extends StatelessWidget {
  const WeekContents({
    super.key,
    required this.weekDates,
    required this.hrd,
    required this.tech,
    required this.followUp,
    required this.allData,
  });

  final List<String> weekDates;
  final List hrd;
  final List tech;
  final List followUp;
  final List<UserDetails> allData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weekDates.length,
      itemBuilder: (BuildContext b, int index) {
        final data = weekDates[index];
        return Card(
          elevation: 0,
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(-4, -4),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 15),
                    padding: const EdgeInsets.only(left: 15),
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 5, color: Colors.red))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.split(' ')[0], // Display only day
                          style: const TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          data.split(' ')[1], // Display only month
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Center(
                              child: Text(
                                "0${hrd.length}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          )),
                      const SizedBox(height: 5),
                      const Text("HRD")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Center(
                              child: Text(
                                "0${tech.length}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          )),
                      const SizedBox(height: 5),
                      const Text("Tech")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Center(
                              child: Text(
                                "0${followUp.length}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          )),
                      const SizedBox(height: 5),
                      const Text("Follow up")
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: Center(
                              child: Text(
                                "${allData.length}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                      const SizedBox(height: 5),
                      const Text("Total")
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
