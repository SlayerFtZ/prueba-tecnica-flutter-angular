import { CurrencyPipe } from '@angular/common';
import { ChangeDetectionStrategy, Component, input, output } from '@angular/core';
import { DiscountPercentPipe } from '@shared/pipes/discount-percent-pipe';
import { Order } from '../../models/order.model';

@Component({
  selector: 'app-order-card',
  imports: [CurrencyPipe, DiscountPercentPipe],
  changeDetection: ChangeDetectionStrategy.OnPush,
  styleUrl: './order-card.css',
  templateUrl: './order-card.html',
})
export class OrderCardComponent {
  readonly order = input.required<Order>();
  readonly viewDetail = output<number>();
}
