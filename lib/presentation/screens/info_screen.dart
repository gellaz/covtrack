import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/blocs/info/info_bloc.dart';
import '../../business/repositories/info/info_repository.dart';
import '../../data/models/info.dart';
import '../widgets/info_list_view.dart';
import '../widgets/logout_button.dart';
import '../widgets/web_link.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InfoBloc(context.repository<InfoRepository>())..add(InfoFetched()),
      child: InfoContent(),
    );
  }
}

class InfoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
        actions: <Widget>[
          LogoutButton(),
        ],
      ),
      body: BlocBuilder<InfoBloc, InfoState>(
        builder: (context, state) {
          if (state is InfoInitial) {
            return _buildInitial();
          } else if (state is InfoLoadInProgress) {
            return _buildLoading();
          } else if (state is InfoLoadSuccess) {
            return _buildLoadedData(context, state.localInfo, state.globalInfo);
          } else if (state is InfoLoadFailure) {
            return _buildInitial();
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildInitial() {
    return Center(
      child: Text('Initial'),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoadedData(
    BuildContext context,
    Info localInfo,
    Info globalInfo,
  ) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _buildDescription(),
              SizedBox(height: 40),
              _buildInfoTitle(context, 'Italy', localInfo.date),
              InfoListView(localInfo),
              SizedBox(height: 40),
              _buildInfoTitle(context, 'Global', globalInfo.date),
              InfoListView(globalInfo),
              SizedBox(height: 40),
              _buildDisclaimer(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      'Below you can find a summary of the sanitary situation in your country and in the world.',
      textAlign: TextAlign.center,
    );
  }

  Widget _buildInfoTitle(
    BuildContext context,
    String title,
    DateTime lastUpdate,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            'Last update: ${lastUpdate.toString().split(' ').first}',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimer(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'All data presented in this section are fetched from the API',
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
        WebLink(
          text: 'covidapi.info',
          url: 'https://covidapi.info/',
        ),
      ],
    );
  }
}
