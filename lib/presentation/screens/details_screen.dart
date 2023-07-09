import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/presentation/blocs/notifications/notifications_bloc.dart';

import '../../domain/entities/push_message.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.pushMessageId});

  final String pushMessageId;

  @override
  Widget build(BuildContext context) {
    final PushMessage? message =
        context.watch<NotificationsBloc>().getMessageById(pushMessageId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles Push'),
      ),
      body: message != null
          ? _DetailsView(message: message)
          : const Center(
              child: Text('Notificación no existe'),
            ),
    );
  }
}

class _DetailsView extends StatelessWidget {
  const _DetailsView({
    required this.message,
  });

  final PushMessage message;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        children: [
          if (message.imageUrl != null) Image.network(message.imageUrl!),
          const SizedBox(height: 30),
          Text(message.title, style: style.titleMedium),
          Text(message.body),
          const Divider(),
          Text(message.data.toString()),
        ],
      ),
    );
  }
}
