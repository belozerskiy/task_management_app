import 'package:graphql/client.dart';

HttpLink httpLink = HttpLink(uri: 'http://192.168.1.39:3000/graphql');

GraphQLClient createClient() {
  return GraphQLClient(
    link: httpLink,
    cache: OptimisticCache(
      dataIdFromObject: typenameDataIdFromObject,
    ),
  );
}
