import 'package:flutter/material.dart';
import 'package:mahindra_finance_task/widgets/week_content.dart';

import '../models/user_details.dart';

class WeekSelected extends StatelessWidget {
  const WeekSelected({
    super.key,
    required TabController tabController,
    required this.allData,
    required this.hrd,
    required this.tech,
    required this.followUp,
    required this.weekDates,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<UserDetails> allData;
  final List hrd;
  final List tech;
  final List followUp;
  final List<String> weekDates;

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
                  isScrollable: true, // Enables scrolling if tabs don't fit
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
                    WeekContents(weekDates: weekDates, hrd: hrd, tech: tech, followUp: followUp, allData: allData),
                    WeekContents(weekDates: weekDates, hrd: hrd, tech: tech, followUp: followUp, allData: allData),
                    WeekContents(weekDates: weekDates, hrd: hrd, tech: tech, followUp: followUp, allData: allData),
                    WeekContents(weekDates: weekDates, hrd: hrd, tech: tech, followUp: followUp, allData: allData),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}


