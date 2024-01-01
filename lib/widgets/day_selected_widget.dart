import 'package:flutter/material.dart';
import 'package:mahindra_finance_task/models/user_details.dart';
import 'package:url_launcher/url_launcher.dart';

class DaySelected extends StatelessWidget {
  const DaySelected({
    Key? key,
    required TabController tabController,
    required this.allData,
    required this.hrd,
    required this.tech,
    required this.followUp,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final List<UserDetails> allData;
  final List hrd;
  final List tech;
  final List followUp;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(-3, 0), // Offset to top-left
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(3, 0), // Offset to top-right
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              height: 5,
              width: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 35),
            DefaultTabController(
              length: 4,
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                isScrollable: true,
                tabs: [
                  Tab(text: 'All (${allData.length})'),
                  Tab(text: 'HRD (${hrd.length})'),
                  Tab(text: 'Tech 1 (${tech.length})'),
                  Tab(text: 'Follow up (${followUp.length})'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCard(allData),
                  _buildCard(hrd),
                  _buildCard(tech),
                  _buildCard(followUp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCard(List dataList) {
  return ListView.builder(
    itemCount: dataList.length,
    itemBuilder: (BuildContext b, int index) {
      final data = dataList[index];
      return Card(
        elevation: 0,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
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
          child: _buildUser(data),
        ),
      );
    },
  );
}

Widget _buildUser(UserDetails data) {
  Color textColor = Colors.black;
  if (data.priority.toLowerCase() == 'high priority') {
    textColor = Colors.red;
  } else {
    textColor = Colors.orange;
  }
  var radius = 20.0;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            data.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              launch('tel://1234567890');
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0.4,
                    spreadRadius: 0.1,
                  ),
                ],
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.phone_outlined, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Text(
        "ID:${data.id}",
        style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Text(
            "Offered: ₹",
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          Text(
            data.offered,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Text(
            "Current: ₹",
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          Text(
            data.current,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: textColor),
            width: radius / 2,
            height: radius / 2,
          ),
          const SizedBox(width: 5),
          Text(
            data.priority,
            style: TextStyle(
                color: textColor), // Change text color based on priority
          ),
        ],
      ),
      const Divider(color: Colors.grey, thickness: 1),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "Due Date",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 5),
              Text(data.date,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          Column(
            children: [
              Text(
                "Level",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 5),
              Text("${data.level}",
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
          Column(
            children: [
              Text(
                "Days Left",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
              const SizedBox(height: 5),
              Text("${data.daysLeft}",
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    ],
  );
}
