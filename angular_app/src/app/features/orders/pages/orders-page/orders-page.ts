import { ChangeDetectionStrategy, Component, computed, inject, signal } from '@angular/core';
import { toSignal } from '@angular/core/rxjs-interop';
import { Router } from '@angular/router';
import { BehaviorSubject, switchMap } from 'rxjs';
import { environment } from '@core/config/environment';
import { AlertService } from '@core/services/alert.service';
import { LoadState } from '@shared/models/load-state';
import { toLoadState } from '@shared/operators/to-load-state';
import { LoadingStateComponent } from '@shared/components/loading-state/loading-state';
import { ErrorStateComponent } from '@shared/components/error-state/error-state';
import { Order } from '../../models/order.model';
import { OrdersService } from '../../services/orders.service';
import { OrderCardComponent } from '../../components/order-card/order-card';
import { OrderFilters, OrderFiltersComponent } from '../../components/order-filters/order-filters';

@Component({
  selector: 'app-orders-page',
  imports: [OrderCardComponent, OrderFiltersComponent, LoadingStateComponent, ErrorStateComponent],
  changeDetection: ChangeDetectionStrategy.OnPush,
  styleUrl: './orders-page.css',
  templateUrl: './orders-page.html',
})
export class OrdersPageComponent {
  private readonly service = inject(OrdersService);
  private readonly router = inject(Router);
  private readonly alerts = inject(AlertService);
  private readonly reload$ = new BehaviorSubject<void>(undefined);

  protected readonly filters = signal<OrderFilters>({ minTotal: null, userId: null });

  protected readonly state = toSignal(
    this.reload$.pipe(
      switchMap(() =>
        this.service
          .getOrders()
          .pipe(toLoadState(environment.messages.loadOrdersError, (m) => this.alerts.error(m))),
      ),
    ),
    { initialValue: { status: 'loading' } as LoadState<Order[]> },
  );

  protected readonly filtered = computed<Order[]>(() => {
    const s = this.state();
    if (s.status !== 'success') return [];
    const { minTotal, userId } = this.filters();
    return s.data.filter(
      (o) => (minTotal === null || o.total >= minTotal) && (userId === null || o.userId === userId),
    );
  });

  protected reload(): void {
    this.reload$.next();
  }

  protected goToDetail(id: number): void {
    void this.router.navigate(['/orders', id]);
  }
}
