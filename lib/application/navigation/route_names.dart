/// Home(Notifications) page
const String homeRoute = '/home';

/// Challenges list page
const String challengesListRoute = '/challenges';

/// Challenge details page
String challengeRoute(String id) => '$challengesListRoute?id=$id';

/// User profile page
const String profileRoute = '/profile';

/// Login page
const String signInRoute = '/signin';

/// Register page
const String signUpRoute = '/signup';

/// Host(add) a challenge page
const String hostChallengeRoute = '/host';

/// Teams and team invitations page
const String teamsRoute = '/teams';

/// New team creation page
const String newTeamRoute = '/newteam';
