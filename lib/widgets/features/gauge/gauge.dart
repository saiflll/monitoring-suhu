import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:testv1/config/color.dart';
import 'package:testv1/models/gauge_value_model.dart';
class RadialGaugeDisplay extends StatelessWidget {
  final GaugeValueModel gaugeData;

  const RadialGaugeDisplay({
    super.key,
    required this.gaugeData,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final List<GaugeRange> gaugeRanges = <GaugeRange>[
      GaugeRange(
        startValue: -20,
        endValue: 40,
        color: Colors.green,
        startWidth: 10,
        endWidth: 10,
      ),
      GaugeRange(
        startValue: 40,
        endValue: 80,
        color: Colors.orange,
        startWidth: 10,
        endWidth: 10,
      ),
      GaugeRange(
        startValue: 80,
        endValue: 150,
        color: Colors.red,
        startWidth: 10,
        endWidth: 10,
      ),
    ];
    final List<GaugePointer> gaugePointers = <GaugePointer>[
      NeedlePointer(
        value: gaugeData.value,
        needleColor: AppColors.blul,
        needleLength: 0.85,
        needleStartWidth: 1,
        needleEndWidth: 1,
        knobStyle: const KnobStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          borderColor: AppColors.blul,
          borderWidth: 0.02,
          sizeUnit: GaugeSizeUnit.factor,
        ),
        tailStyle: const TailStyle(
          length: 0.2,
          width: 1,
          color: AppColors.blul,
          lengthUnit: GaugeSizeUnit.factor,
        ),
        enableAnimation: true,
      ),
      RangePointer(
        value: gaugeData.value,
        width: 0.10,
        gradient: const SweepGradient(
          colors: <Color>[Colors.green, Colors.orange, Colors.red],
          stops: <double>[0.2, 0.5, 2.5],
        ),
        sizeUnit: GaugeSizeUnit.factor,
        cornerStyle: CornerStyle.bothCurve,
      ),
    ];

    final List<GaugeAnnotation> gaugeAnnotations = <GaugeAnnotation>[
      GaugeAnnotation(
        positionFactor: 0.7, 
        widget: Text('${gaugeData.value.toStringAsFixed(1)}${gaugeData.unit}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        angle: 90,
      ),
      GaugeAnnotation(
        angle: 270,
        positionFactor: 0.4, // Adjusted position
        widget: Text(
          gaugeData.title,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    ];

    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          annotations: gaugeAnnotations,
          minimum: -20,
          maximum: 150,
          radiusFactor: 0.7,
      
          axisLineStyle: const AxisLineStyle(
            thickness: 0.1,
            color: Color.fromARGB(158, 158, 158, 158),
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          showLabels: false,
          showTicks: false,
          pointers: gaugePointers,
        ),
      ],
    );
  }
}
class LinearGaugeDisplay extends StatelessWidget {
  const LinearGaugeDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      margin: const EdgeInsets.all(5), 
      child: SfLinearGauge(
        minimum: 0.0,
        maximum: 100.0,
        orientation: LinearGaugeOrientation.horizontal,
        majorTickStyle: const LinearTickStyle(length: 20), 
        axisLabelStyle: const TextStyle(fontSize: 12.0, color: Colors.black), 
        axisTrackStyle: const LinearAxisTrackStyle( 
          color: Colors.cyan,
          edgeStyle: LinearEdgeStyle.bothFlat,
          thickness: 30.0,
          borderColor: Colors.grey,
        ),
      ),
    );
  }
}