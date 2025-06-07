// import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/presentation/ui/pages/features/result/package/package_from_loading_to_scan_result.dart';
import 'package:skinisense/presentation/ui/pages/features/result/package/package_from_resul_scan_to_result_recom.dart';
import 'package:skinisense/presentation/ui/widget/custom_button.dart';

import '../../../../../config/common/image_assets.dart';
import '../../../../../domain/services/sharedPreferences-services.dart';

class ResultScanPageScope extends StatelessWidget {
  final PackageFromLoadingToScanResult result;
  const ResultScanPageScope({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return ResultScanPage(result: result);
  }
}

class ResultScanPage extends StatefulWidget {
  final PackageFromLoadingToScanResult result;
  const ResultScanPage({super.key, required this.result});

  @override
  State<ResultScanPage> createState() => _ResultScanPageState();
}

class _ResultScanPageState extends State<ResultScanPage> {
  int selectedIndex = 1; // Index item yang diklik
  late List<Map<String, dynamic>> reorderedConditions;

  @override
  void initState() {
    // TODO: implement initState
    // Pindah nilai tertinggi ke tengah
    reorderedConditions = [
      widget.result.condition[1], // nilai tengah (kedua terbesar)
      widget.result.condition[0], // nilai tertinggi
      widget.result.condition[2], // nilai terkecil
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: null,
        backgroundColor: lightBlueColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                backgroundColor: lightBlueColor,
                automaticallyImplyLeading: false,
                expandedHeight: SizeConfig.calHeightMultiplier(280),
                flexibleSpace: FlexibleSpaceBar(background: CardResultWidget()),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(height: SizeConfig.calHeightMultiplier(20)),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    margin: EdgeInsets.only(
                      top: 0,
                      left: SizeConfig.calWidthMultiplier(24),
                      right: SizeConfig.calWidthMultiplier(24),
                      bottom: SizeConfig.calHeightMultiplier(16),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.calHeightMultiplier(20),
                      horizontal: SizeConfig.calHeightMultiplier(20),
                    ),
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        _BuildName(),
                        Text(
                          'Berikut laporan hasil analisis kulitmu by SCIN',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeConfig.calHeightMultiplier(12),
                          ),
                        ),

                        CustomRadialGauge(
                          value: reorderedConditions[selectedIndex]['value'],
                          label: reorderedConditions[selectedIndex]['label'],
                          colorsGauge:
                              reorderedConditions[selectedIndex]['value'] < 30
                              ? Colors.green
                              : reorderedConditions[selectedIndex]['value'] < 50
                              ? Colors.yellow
                              : Colors.red,
                        ),

                        Text(
                          'Hasil Analisa Kulit Anda',
                          style: TextStyle(
                            color: blueTextColor,
                            fontSize: SizeConfig.calHeightMultiplier(16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Kami telah menganalisis kondisi kulit Anda untuk memberikan informasi yang akurat dan mendetail. Berikut adalah hasilnya:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeConfig.calHeightMultiplier(12),
                          ),
                        ),
                        SizedBox(height: SizeConfig.calHeightMultiplier(60)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(3, (index) {
                            final item = reorderedConditions[index];
                            final isSelected = selectedIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: Container(
                                width: SizeConfig.calWidthMultiplier(80),
                                height: SizeConfig.calWidthMultiplier(80),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: isSelected
                                      ? primaryBlueColor
                                      : primaryBlueColor.withOpacity(.5),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: Colors.blueAccent,
                                            blurRadius: 8,
                                          ),
                                        ]
                                      : [],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${item['value'].toStringAsFixed(0)}%',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: SizeConfig.calWidthMultiplier(
                                          20,
                                        ),
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      item['label'],
                                      style: TextStyle(
                                        fontSize: SizeConfig.calWidthMultiplier(
                                          12,
                                        ),
                                        color: Colors.white.withOpacity(.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),

                        SizedBox(height: SizeConfig.calHeightMultiplier(90)),
                        Text(
                          widget.result.description,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeConfig.calHeightMultiplier(12),
                          ),
                        ),
                        SizedBox(height: SizeConfig.calHeightMultiplier(20)),
                        Text(
                          'Temukan rekomendasi produk perawatan terbaik untuk kulit Anda di sini!',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeConfig.calHeightMultiplier(12),
                          ),
                        ),
                        SizedBox(height: SizeConfig.calHeightMultiplier(50)),
                        CustomButton(
                          onPressed: () {
                            debugPrint('Clicked');
                            Navigator.of(context).pushNamed(
                              routeResultRecom,
                              arguments: PackageFromResulScanToResultRecom(
                                acne: widget.result.acne,
                                flex: widget.result.flex,
                                wringkle: widget.result.wrinkle,
                                id: widget.result.id,
                                recomDesc: widget.result.recomDesc,
                              ),
                            );
                          },
                          text: 'Rekomendasi Product',
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              // Membungkus GridView.builder di dalam SliverToBoxAdapter
              // Wrap the BlocBuilder with SliverToBoxAdapter to handle non-sliver content
              // Tambahkan padding di bawah
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.calHeightMultiplier(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _BuildName extends StatefulWidget {
  const _BuildName({super.key});

  @override
  State<_BuildName> createState() => _BuildNameState();
}

class _BuildNameState extends State<_BuildName> {
  late Future<String> _userNameFuture;

  @override
  void initState() {
    super.initState();
    _userNameFuture = _fetchUserName();
  }

  Future<String> _fetchUserName() async {
    try {
      final name = await di<SharedPreferencesService>().getString('name');
      return name ?? 'Guest';
    } catch (e) {
      // Return default value if there's an error
      return 'Guest';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _userNameFuture,
      builder: (context, snapshot) {
        // Handle all possible states
        final userName = switch (snapshot) {
          AsyncSnapshot(connectionState: ConnectionState.waiting) => 'Loading...',
          AsyncSnapshot(hasError: true) => 'Guest', // Fallback to 'Guest' on error
          AsyncSnapshot(data: final data) => data,
          _ => 'Guest', // Default fallback
        };

        return Text(
          'Hai, $userName',
          style: TextStyle(
            color: primaryBlueColor,
            fontSize: SizeConfig.calHeightMultiplier(20),
            fontWeight: FontWeight.w600,
          ),
        );
      },
    );
  }
}

class CardResultWidget extends StatefulWidget {
  const CardResultWidget({super.key});

  @override
  State<CardResultWidget> createState() => _CardResultWidgetState();
}

class _CardResultWidgetState extends State<CardResultWidget> {
  final ScrollController _scrollController = ScrollController();

  double _scrollPosition = 0.0;
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    _loadImagesFromSharedPreferences();
    _scrollController.addListener(() {
      setState(() {
        _scrollPosition = _scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadImagesFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    final imageRight = prefs.getString('scan_face_right');
    final imageLeft = prefs.getString('scan_face_left');
    final imageFront = prefs.getString('scan_face_front');

    setState(() {
      images = [
        if (imageRight != null) imageRight,
        if (imageLeft != null) imageLeft,
        if (imageFront != null) imageFront,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    // final double maxScroll = _scrollController.position.hasContentDimensions ? _scrollController.position.maxScrollExtent : 0;

    // final double scrollFraction = maxScroll > 0
    //     ? (_scrollPosition / maxScroll).clamp(0.0, 1.0)
    //     : 0.0;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: primaryBlueColor,
      ),
      width: double.infinity,
      height: SizeConfig.calHeightMultiplier(260),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              // horizontal: SizeConfig.calWidthMultiplier(24),
              vertical: SizeConfig.calHeightMultiplier(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.calHeightMultiplier(12)),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    'Face Scan Result',
                    style: TextStyle(
                      fontSize: SizeConfig.calHeightMultiplier(18),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.calHeightMultiplier(20)),
                SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        margin: EdgeInsets.only(left: 24),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.grey,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child:
                              images[0] != null && File(images[0]).existsSync()
                              ? Image.file(File(images[0]), fit: BoxFit.fill)
                              : Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Image.asset(
                                    imageDefault,
                                    color: Colors.black38,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.calWidthMultiplier(10)),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.grey,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child:
                              images[1] != null && File(images[1]).existsSync()
                              ? Image.file(File(images[1]), fit: BoxFit.fill)
                              : Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Image.asset(
                                    imageDefault,
                                    color: Colors.black38,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.calWidthMultiplier(10)),
                      Container(
                        width: 150,
                        height: 150,
                        margin: EdgeInsets.only(right: 24),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          color: Colors.grey,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child:
                              images[2] != null && File(images[2]).existsSync()
                              ? Image.file(File(images[2]), fit: BoxFit.fill)
                              : Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Image.asset(
                                    imageDefault,
                                    color: Colors.black38,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRadialGauge extends StatelessWidget {
  const CustomRadialGauge({
    super.key,
    required this.colorsGauge,
    required this.value,
    required this.label,
  });
  final Color colorsGauge;
  final double value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AnimatedRadialGauge(
      duration: Duration(seconds: 1),
      value: value,
      radius: 200,
      builder: (context, child, value) => _buildGaugeContent(value, context),
      axis: GaugeAxis(
        min: 0,
        max: 100,
        degrees: 180,
        style: GaugeAxisStyle(
          thickness: 25,
          background: Color(0xFFDFE2EC),
          segmentSpacing: 4,
        ),
        progressBar: GaugeProgressBar.rounded(color: colorsGauge),
      ),
    );
  }

  /// Builds the content inside the gauge (percentage and label).
  Widget _buildGaugeContent(double value, BuildContext ctx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${value.round()}%",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.calWidthMultiplier(32),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: SizeConfig.calWidthMultiplier(16)),
        ),
        // SizedBox(height: MediaQuery.of(ctx).size.height * 1,)
      ],
    );
  }
}
