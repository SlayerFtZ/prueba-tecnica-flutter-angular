import { Routes } from '@angular/router';

export const ORDERS_ROUTES: Routes = [
  {
    path: '',
    loadComponent: () =>
      import('./pages/orders-page/orders-page')
        .then((m) => m.OrdersPageComponent),
  },
  {
    path: ':id',
    loadComponent: () =>
      import('./pages/order-detail/order-detail')
        .then((m) => m.OrderDetailComponent),
  },
];
