/// Home(Notifications) page path
const String homeRoute = '/home';

/// Challenges list page path
const String challengesListRoute = '/challenges';

/// Challenge details page path
String challengeRoute(String id) => '$challengesListRoute?id=$id';

/// User profile page path
const String profileRoute = '/profile';

/// Login page path
const String signInRoute = '/signin';

/// Register page path
const String signUpRoute = '/signup';

/// Host(add) a challenge page path
const String hostChallengeRoute = '/host';

/// Teams and team invitations page path
const String teamsRoute = '/teams';

/// New team creation page path
const String newTeamRoute = '/newteam';

/// Team chat base path
const String chatRouteBase = '/chat';

/// Team chat page path
String chatRoute(String teamId) => '$chatRouteBase?id=$teamId';
