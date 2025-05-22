// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:skinisense/presentation/ui/widget/custom_button.dart';

class ResultScanPage extends StatelessWidget {
  const ResultScanPage({super.key});

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
                flexibleSpace: FlexibleSpaceBar(
                  background: CardResultWidget(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: SizeConfig.calHeightMultiplier(20)),
                    Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        margin: EdgeInsets.only(
                          top: 0,
                          left: SizeConfig.calWidthMultiplier(24),
                          right: SizeConfig.calWidthMultiplier(24),
                          bottom: SizeConfig.calHeightMultiplier(16),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.calHeightMultiplier(20),
                            horizontal: SizeConfig.calHeightMultiplier(20)),
                        child: Wrap(
                          runSpacing: 10,
                          children: [
                            Text(
                              'Hai, Jennife Lawr',
                              style: TextStyle(
                                color: primaryBlueColor,
                                fontSize: SizeConfig.calHeightMultiplier(20),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Berikut laporan hasil analisis kulitmu by SCIN',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.calHeightMultiplier(12),
                              ),
                            ),
                            CustomRadialGauge(
                              value: 90,
                              label: "Acne",
                            ),
                            Text(
                              'Hasil Analisa Kulit Anda',
                              style: TextStyle(
                                color: primaryBlueColor,
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
                            Row(
                              children: [
                                Container(
                                  width: SizeConfig.calWidthMultiplier(80),
                                  height: SizeConfig.calWidthMultiplier(80),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    color: primaryBlueColor.withOpacity(.5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "50%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.calWidthMultiplier(
                                                    20),
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "Flex",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.calWidthMultiplier(
                                                    12),
                                            color:
                                                Colors.white.withOpacity(.8)),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: SizeConfig.calWidthMultiplier(90),
                                  height: SizeConfig.calWidthMultiplier(90),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    color: primaryBlueColor,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "89%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.calWidthMultiplier(
                                                    20),
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "Acne",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.calWidthMultiplier(
                                                    12),
                                            color:
                                                Colors.white.withOpacity(.8)),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  width: SizeConfig.calWidthMultiplier(80),
                                  height: SizeConfig.calWidthMultiplier(80),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    color: primaryBlueColor.withOpacity(.5),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "45%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.calWidthMultiplier(
                                                    20),
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "Wrinkle",
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.calWidthMultiplier(
                                                    12),
                                            color:
                                                Colors.white.withOpacity(.8)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Dari hasil analisa, kulit Anda menunjukkan 89% masalah Acne, 50% flek, dan 45% Wringkle. Fokus utama? Bye-bye Acne dulu, sambil merawat flek dan kerutan untuk kulit sehat dan glowing!,',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.calHeightMultiplier(12),
                              ),
                            ),
                            Text(
                              'Temukan rekomendasi produk perawatan terbaik untuk kulit Anda di sini!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.calHeightMultiplier(12),
                              ),
                            ),
                            SizedBox(
                                height: SizeConfig.calHeightMultiplier(50)),
                            CustomButton(
                                onPressed: () {
                                  debugPrint('Clicked');
                                  Navigator.of(context).pushReplacementNamed(routeResultRecom);
                                }, text: 'Rekomendasi Product')
                          ],
                        )),
                  ],
                ),
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

class CardResultWidget extends StatefulWidget {
  const CardResultWidget({super.key});

  @override
  State<CardResultWidget> createState() => _CardResultWidgetState();
}

class _CardResultWidgetState extends State<CardResultWidget> {
  final ScrollController _scrollController = ScrollController();

  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollPosition = _scrollController.position.pixels;
      });
    });
  }

  final List<String> images = [
    'https://images.unsplash.com/photo-1719603785926-84d214438120?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1719603785926-84d214438120?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];

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
                horizontal: SizeConfig.calWidthMultiplier(24),
                vertical: SizeConfig.calHeightMultiplier(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.calHeightMultiplier(12)),
                  Text(
                    'Face Scan Result',
                    style: TextStyle(
                        fontSize: SizeConfig.calHeightMultiplier(18),
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.grey,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              images[0],
                              fit: BoxFit.fill,
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
                            child: Image.network(
                              images[0],
                              fit: BoxFit.fill,
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
                            child: Image.network(
                              images[0],
                              fit: BoxFit.fill,
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
        ));
  }
}

class CustomRadialGauge extends StatelessWidget {
  const CustomRadialGauge({
    super.key,
    required this.value,
    required this.label,
  });

  final double value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AnimatedRadialGauge(
      duration: const Duration(seconds: 1),
      value: value,
      radius: 200,
      builder: (context, child, value) => _buildGaugeContent(value),
      axis: const GaugeAxis(
        min: 0,
        max: 100,
        degrees: 180,
        style: GaugeAxisStyle(
          thickness: 25,
          background: Color(0xFFDFE2EC),
          segmentSpacing: 4,
        ),
        progressBar: GaugeProgressBar.rounded(
          color: primaryBlueColor,
        ),
      ),
    );
  }

  /// Builds the content inside the gauge (percentage and label).
  Widget _buildGaugeContent(double value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${value.round()}%",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.calWidthMultiplier(40),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: SizeConfig.calWidthMultiplier(20),
          ),
        ),
      ],
    );
  }
}
