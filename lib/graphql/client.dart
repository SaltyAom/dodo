import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final httpLink = HttpLink(
  'https://api.dodo.saltyaom.com/graphql',
);

final client = GraphQLClient(
  link: httpLink,
  cache: GraphQLCache(),
);

final flutterClient = ValueNotifier(client);
