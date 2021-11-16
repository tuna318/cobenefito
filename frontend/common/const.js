export const UserRole = {
  MANAGER: 'manager',
  EMPLOYEE: 'employee',
}

export const RoleDefaultRoutes = {
  [UserRole.EMPLOYEE]: '/employee/coupons',
  [UserRole.MANAGER]: '/manager/employees',
};

export const RoleWhitelistedRoutes = {
  [UserRole.MANAGER]: [/^\/manager.*$/], // Any manager routes
  [UserRole.EMPLOYEE]: [/^\/employee.*$/], // Any employee routes
};

export const UsuableFor = {
  SHOPPING: 'shopping',
  TRAVEL: 'travel',
  HEALTH: 'health',
  FOOD: 'food',
}