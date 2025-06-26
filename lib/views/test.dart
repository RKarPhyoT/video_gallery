import 'package:flutter/material.dart';

class TournamentSchedulePage extends StatelessWidget {
  const TournamentSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Header with schedule title
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  'LỊCH THI ĐẤU',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            
            // Date selector
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: 9,
                itemBuilder: (context, index) {
                  final days = ['09', '10', '11', '12', '13', '14', '15', '16', '16'];
                  final weekdays = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN', 'T2', 'T3'];
                  final isSelected = index == 4; // 13 is selected
                  
                  return Container(
                    width: 50,
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFFFFD700) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weekdays[index],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          days[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.black : Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Stats bar
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.live_tv, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text('6', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Row(
                    children: [
                      Icon(Icons.emoji_events, color: Color(0xFFFFD700), size: 20),
                      SizedBox(width: 4),
                      Text('GIẢI ĐẤU', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: Color(0xFFFFD700), size: 20),
                      SizedBox(width: 4),
                      Text('THỜI GIAN', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.search, color: Colors.grey[600]),
                ],
              ),
            ),
            
            // Tournament list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: 4,
                itemBuilder: (context, sectionIndex) {
                  return Column(
                    children: [
                      // Tournament header
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.sports_esports, color: Colors.red),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Marble Magic P8',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                'HÔM NAY THÁNG 12',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Match list
                      ...List.generate(3, (matchIndex) {
                        final matchTypes = ['LIVE', 'Đặt lịch', 'Huy lịch'];
                        final matchColors = [Colors.red, Color(0xFFFFD700), Colors.grey];
                        final matchIcons = [Icons.live_tv, Icons.schedule, Icons.cancel];
                        
                        return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              // Time column
                              Container(
                                width: 60,
                                child: Column(
                                  children: [
                                    Text(
                                      '01:00',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      '13/09',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              SizedBox(width: 8),
                              
                              // Status badge
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: matchColors[matchIndex],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(matchIcons[matchIndex], color: Colors.white, size: 14),
                                    SizedBox(width: 4),
                                    Text(
                                      matchTypes[matchIndex],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              SizedBox(width: 8),
                              
                              // Match card
                              Expanded(
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage('https://images.unsplash.com/photo-1542751371-adc38448a05e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: LinearGradient(
                                        colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.9),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            'Núi Lửa Hawaii',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            '03:59',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      
                      SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}