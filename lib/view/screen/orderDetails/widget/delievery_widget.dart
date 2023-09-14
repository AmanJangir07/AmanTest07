import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DeliveryTimeline extends StatefulWidget {
  String? status;
  DeliveryTimeline(this.status);

  @override
  DeliveryTimelineState createState() => DeliveryTimelineState();
}

class DeliveryTimelineState extends State<DeliveryTimeline> {
  ScrollController? _scrollController;

  final deliverySteps = [
    'Ordered',
    'Processed',
    'Dispatched',
    'Delievered',
  ];
  final orderStatus = [
    'ORDERED',
    'PROCESSED',
    'DISPATCHED',
    'DELIEVERED',
  ];

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int currentStep = orderStatus.indexOf(widget.status!) + 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController!.jumpTo(currentStep * 120.0);
    });

    return Container(
      height: 70,
      child: Container(
        //constraints: const BoxConstraints(maxHeight: 210),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          itemCount: deliverySteps.length,
          itemBuilder: (BuildContext context, int index) {
            final step = deliverySteps[index];
            var indicatorSize = 29.0;
            var beforeLineStyle = LineStyle(
              color: Colors.green.withOpacity(0.8),
            );

            _DeliveryStatus status;
            LineStyle? afterLineStyle;
            if (index < currentStep) {
              status = _DeliveryStatus.done;
            } else if (index > currentStep) {
              status = _DeliveryStatus.todo;
              indicatorSize = 20;
              beforeLineStyle = const LineStyle(color: Color(0xFF747888));
            } else {
              afterLineStyle = const LineStyle(color: Color(0xFF747888));
              status = _DeliveryStatus.doing;
            }

            return Container(
              width: 95,
              child: TimelineTile(
                axis: TimelineAxis.horizontal,
                alignment: TimelineAlign.manual,
                lineXY: 0.3,
                isFirst: index == 0,
                isLast: index == deliverySteps.length - 1,
                beforeLineStyle: beforeLineStyle,
                afterLineStyle: afterLineStyle,
                indicatorStyle: IndicatorStyle(
                  width: indicatorSize,
                  height: indicatorSize,
                  indicator: _IndicatorDelivery(status: status),
                ),
                endChild: _EndChildDelivery(
                  text: step,
                  current: index == currentStep,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

enum _DeliveryStatus { done, doing, todo }

class _EndChildDelivery extends StatelessWidget {
  const _EndChildDelivery({
    Key? key,
    required this.text,
    required this.current,
  }) : super(key: key);

  final String text;
  final bool current;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IndicatorDelivery extends StatelessWidget {
  const _IndicatorDelivery({Key? key, this.status}) : super(key: key);

  final _DeliveryStatus? status;

  @override
  Widget build(BuildContext context) {
    switch (status!) {
      case _DeliveryStatus.done:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          child: const Center(
            child: Icon(Icons.check, color: Color(0xFF5D6173)),
          ),
        );
      case _DeliveryStatus.doing:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow,
          ),
          child: const Center(
            child: SizedBox(
                child: Icon(Icons.pending_actions, color: Colors.white)),
          ),
        );
      case _DeliveryStatus.todo:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF747888),
          ),
          child: Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF5D6173),
              ),
            ),
          ),
        );
    }
    return Container();
  }
}
