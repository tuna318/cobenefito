import { RoleDefaultRoutes, RoleWhitelistedRoutes } from '../common/const';

export default function({ $auth, route, redirect }) {
  if (!$auth.loggedIn) {
    return;
  }

  const userRole = $auth.user.user_role;
  const isRouteWhitelisted = RoleWhitelistedRoutes[userRole].some(r => route.fullPath.match(r));
  if (isRouteWhitelisted) {
    return;
  }

  redirect(RoleDefaultRoutes[userRole]);
}
