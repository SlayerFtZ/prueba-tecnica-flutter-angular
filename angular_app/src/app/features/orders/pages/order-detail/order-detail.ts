import { CurrencyPipe } from '@angular/common';
import {
  ChangeDetectionStrategy,
  Component,
  inject,
  input,
} from '@angular/core';
import { toObservable, toSignal } from '@angular/core/rxjs-interop';
import { RouterLink } from '@angular/router';
import { switchMap } from 'rxjs';

import { environment } from '@core/config/environment';
import { AlertService } from '@core/services/alert.service';

import { LoadState } from '@shared/models/load-state';
import { toLoadState } from '@shared/operators/to-load-state';
import { LoadingStateComponent } from '@shared/components/loading-state/loading-state';

import { Order } from '../../models/order.model';
import { OrdersService } from '../../services/orders.service';
import { OrderItemsComponent } from '../../components/order-items/order-items';
import { DiscountPercentPipe } from '../../../../shared/pipes/discount-percent-pipe';

@Component({
  selector: 'app-order-detail',
  imports: [
    CurrencyPipe,
    RouterLink,
    LoadingStateComponent,
    OrderItemsComponent,
    DiscountPercentPipe,
  ],
  changeDetection: ChangeDetectionStrategy.OnPush,
  styleUrl: './order-detail.css',
  templateUrl: './order-detail.html',
})
export class OrderDetailComponent {
  private readonly service = inject(OrdersService);
  private readonly alerts = inject(AlertService);

  /**
   * Llega desde la ruta :id gracias a withComponentInputBinding().
   */
  readonly id = input<string>();

  protected readonly state = toSignal(
    toObservable(this.id).pipe(
      switchMap((id) => {
        if (!id) {
          return [
            {
              status: 'error',
              message: 'No se recibió el identificador del pedido.',
            } as LoadState<Order>,
          ];
        }

        return this.service
          .getOrder(Number(id))
          .pipe(
            toLoadState(
              environment.messages.loadOrderError,
              (message) => this.alerts.error(message),
            ),
          );
      }),
    ),
    {
      initialValue: {
        status: 'loading',
      } as LoadState<Order>,
    },
  );
}
