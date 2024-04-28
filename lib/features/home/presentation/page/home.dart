import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod_weather_app/core/common_widgets/buttons.dart';
import 'package:flutter_riverpod_weather_app/core/common_widgets/cached_network_image_builder.dart';
import 'package:flutter_riverpod_weather_app/core/common_widgets/textfields.dart';
import 'package:flutter_riverpod_weather_app/features/home/data/entity/weather.dart';
import 'package:flutter_riverpod_weather_app/features/home/di/di.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/data/entities/result_state.dart';
import 'package:intl/intl.dart';



class HomePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weatherInfoNotifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Riverpod Weather App"),),
      body: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
        child: Column(
          children: [
            _SearchBarView(),
            state.when(
                data: (data) {
                  return _WeatherInfoView(data);
                },
                error: (error) {
                  return const Text("Network Error !");
                },
                loading: () => const CircularProgressIndicator(),
                idle: () {
                  return const SizedBox.shrink();
                }),
          ],
        ),
      ),
    );
  }
}

class _WeatherInfoView extends StatelessWidget {
  final Weather info;

  const _WeatherInfoView(
    this.info, {
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 24,
              ),
              const SizedBox(height: 20,),
              Text(
                '${info.location?.name}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Text(
            '${info.location?.localtime}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 50,
                  child: CustomCachedNetworkImage(
                      'http://${info.current?.condition?.icon?.substring(2)}')),
              const SizedBox(height: 20,),
              Text(
                '${info.current?.tempC}°C',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 36),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Text(
            'Feels like ${info.current?.feelsLikeTempC}° C',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium!.color),
          ),
          const SizedBox(height: 20,),
          Text(
            '${info.current?.condition?.text}',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium!.color),
          ),

          const SizedBox(height: 20.0,),

          SizedBox(height: 120,
          child: ListView.builder(
              itemCount: info.forecast?.forecastday?.elementAt(0).hours!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return SizedBox(
                    height: 100,
                    child: Column(
                      children: [
                        Text("${info.forecast?.forecastday?.elementAt(0).hours!.elementAt(index).time}"),
                        Text(DateFormat('h a').format(DateTime.parse("${info.forecast?.forecastday?.elementAt(0).hours!.elementAt(index).time}"))),

                        SizedBox(
                            width: 50,
                            child: CustomCachedNetworkImage(
                                'http://${info.forecast?.forecastday?.elementAt(0).hours!.elementAt(index).condition?.icon?.substring(2)}')),
                        Text("${info.forecast?.forecastday?.elementAt(0).hours!.elementAt(index).tempC}"),
                      ],
                    ));
              }),),

          const SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sunrise ${info.forecast?.forecastday?.elementAt(0).astro?.sunrise}'),
              const SizedBox(width: 20,),
              Text('Sunset ${info.forecast?.forecastday?.elementAt(0).astro?.sunset}'),
            ],
          ),

          const SizedBox(height: 20,),

          Text(
            'UV index ${info.current?.uv}',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontSize: 36),
          ),

        ],
      ),
    );
  }
}

class _SearchBarView extends HookConsumerWidget {
  _SearchBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _textController = useTextEditingController();
    final queryString = useState('');

    // listen for state change
    ref
      .listen<ResultState>(weatherInfoNotifier, (previous, next) {
        next.mapOrNull(
          // error: (error) {},
          data: (data) {
            ref
                .read(savedLocationNotifier.notifier)
                .saveLocation(_textController.text);
          },
        );
      });
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: SizedBox(
              width: 250,
              child: PrimaryTextField(
                controller: _textController,
                onSaved: (_) {},
                onChanged: (String? val) {
                  if (val != null) {
                    queryString.value = val;
                  }
                },
                hintTxt: 'Enter City Name',
              ),
            )),
        // SBC.mW,
        PrimaryButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            ref
                .read(weatherInfoNotifier.notifier)
                .getWeatherInfoByLocation(city: _textController.text);
          },
          title:'Search',
          height: 48,
          width: 80,
        ),
      ],
    );
  }
}
