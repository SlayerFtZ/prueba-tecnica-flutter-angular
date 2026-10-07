import { CurrencyPipe } from '@angular/common';
import { ChangeDetectionStrategy, Component, inject } from '@angular/core';
import { toSignal } from '@angular/core/rxjs-interop';
import { forkJoin, map } from 'rxjs';
import { environment } from '@core/config/environment';
import { AlertService } from '@core/services/alert.service';
import { LoadState } from '@shared/models/load-state';
import { toLoadState } from '@shared/operators/to-load-state';
import { LoadingStateComponent } from '@shared/components/loading-state/loading-state';
import { StatCardComponent } from '@shared/components/stat-card/stat-card';
import { OrdersService } from '../../../orders/services/orders.service';
import { ProductsService } from '../../../products/services/products.service';

interface DashboardStats {
  orders: number;
  revenue: number;
  avgTicket: number;
  products: number;
}

@Component({
  selector: 'app-dashboard',
  imports: [LoadingStateComponent, StatCardComponent],
  providers: [CurrencyPipe],
  changeDetection: ChangeDetectionStrategy.OnPush,
  styleUrl: './dashboard.css',
  templateUrl: './dashboard.html',
})
export class DashboardComponent {
  private readonly orders = inject(OrdersService);
  private readonly products = inject(ProductsService);
  private readonly alerts = inject(AlertService);
  private readonly currency = inject(CurrencyPipe);

  protected readonly state = toSignal(
    forkJoin({ orders: this.orders.getOrders(), products: this.products.getProducts() }).pipe(
      map(({ orders, products }): DashboardStats => {
        const revenue = orders.reduce((sum, o) => sum + o.discountedTotal, 0);
        return {
          orders: orders.length,
          revenue,
          avgTicket: orders.length ? revenue / orders.length : 0,
          products: products.length,
        };
      }),
      toLoadState(environment.messages.loadDashboardError, (m) => this.alerts.error(m)),
    ),
    { initialValue: { status: 'loading' } as LoadState<DashboardStats> },
  );

  protected money(value: number): string {
    return this.currency.transform(value) ?? '';
  }
}
