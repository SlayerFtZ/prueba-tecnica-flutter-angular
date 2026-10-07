import { CurrencyPipe } from '@angular/common';
import { ChangeDetectionStrategy, Component, input } from '@angular/core';
import { OrderProduct } from '../../models/order.model';

@Component({
  selector: 'app-order-items',
  imports: [CurrencyPipe],
  changeDetection: ChangeDetectionStrategy.OnPush,
  styleUrl: './order-items.css',
  templateUrl: './order-items.html',
})
export class OrderItemsComponent {
  readonly products = input.required<OrderProduct[]>();
}
