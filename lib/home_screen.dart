import 'package:flutter/material.dart';
import 'package:water_tracker/water_track.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _numberOfGlassController = TextEditingController(
    text: '1',
  );

  List<WaterTrack> waterTrackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker App'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWaterTrackCounter(),
          _buildWaterTrackInput(),
          const SizedBox(height: 24),
          Expanded(
            child: _buildWaterTrackHistory(),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterTrackCounter() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          getTotalGlassCount().toString(),
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          'Glass/s',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildWaterTrackInput() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                controller: _numberOfGlassController,
              ),
            ),
            TextButton(
              onPressed: _addNewWaterTrack,
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
              ),
              child: const Text('Add'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWaterTrackHistory() {
    return ListView.separated(
      itemCount: waterTrackList.length,
      itemBuilder: (context, index) {
        return _buildWaterTrackListTile(index: index);
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

  ListTile _buildWaterTrackListTile({required int index}) {
    final WaterTrack waterTrack = waterTrackList[index];

    return ListTile(
      title: Text(
          '${waterTrack.dateTime.hour}:${waterTrack.dateTime.minute.toString().padLeft(2, '0')}'),
      subtitle: Text(
          '${waterTrack.dateTime.day}-${waterTrack.dateTime.month}-${waterTrack.dateTime.year}'),
      leading: CircleAvatar(
        child: Text(waterTrack.numberOfGlass.toString()),
      ),
      trailing: IconButton(
        onPressed: () {
          _removeWaterTrack(waterTrack);
        },
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }

  int getTotalGlassCount() {
    int counter = 0;

    for (WaterTrack waterTrack in waterTrackList) {
      counter += waterTrack.numberOfGlass;
    }

    return counter;
  }

  void _addNewWaterTrack() {
    if (_numberOfGlassController.text.isEmpty) {
      _numberOfGlassController.text = '1';
    }

    final int numberOfGlass = int.tryParse(_numberOfGlassController.text) ?? 1;

    WaterTrack waterTrack = WaterTrack(
      numberOfGlass: numberOfGlass,
      dateTime: DateTime.now(),
    );

    setState(() {
      waterTrackList.add(waterTrack);
    });
  }

  void _removeWaterTrack(WaterTrack waterTrack) {
    setState(() {
      waterTrackList.remove(waterTrack);
    });
  }
}
