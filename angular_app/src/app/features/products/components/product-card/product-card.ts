import { CurrencyPipe } from '@angular/common';
import { ChangeDetectionStrategy, Component, input, output } from '@angular/core';
import { Product } from '../../models/product.model';

@Component({
  selector: 'app-product-card',
  imports: [CurrencyPipe],
  changeDetection: ChangeDetectionStrategy.OnPush,
  styleUrl: './product-card.css',
  templateUrl: './product-card.html',
})
export class ProductCardComponent {
  readonly product = input.required<Product>();
  readonly viewDetail = output<Product>();
}
