import { ChangeDetectionStrategy, Component, computed, inject } from '@angular/core';
import { toSignal } from '@angular/core/rxjs-interop';
import { FormControl, ReactiveFormsModule } from '@angular/forms';
import { BehaviorSubject, switchMap } from 'rxjs';
import { environment } from '@core/config/environment';
import { AlertService } from '@core/services/alert.service';
import { LoadState } from '@shared/models/load-state';
import { toLoadState } from '@shared/operators/to-load-state';
import { LoadingStateComponent } from '@shared/components/loading-state/loading-state';
import { ErrorStateComponent } from '@shared/components/error-state/error-state';
import { Product } from '../../models/product.model';
import { ProductsService } from '../../services/products.service';
import { ProductCardComponent } from '../../components/product-card/product-card';

@Component({
  selector: 'app-products-page',
  imports: [ReactiveFormsModule, ProductCardComponent, LoadingStateComponent, ErrorStateComponent],
  changeDetection: ChangeDetectionStrategy.OnPush,
  styleUrl: './products-page.css',
  templateUrl: './products-page.html',
})
export class ProductsPageComponent {
  private readonly service = inject(ProductsService);
  private readonly alerts = inject(AlertService);
  private readonly reload$ = new BehaviorSubject<void>(undefined);

  protected readonly search = new FormControl('', { nonNullable: true });
  private readonly term = toSignal(this.search.valueChanges, { initialValue: '' });

  protected readonly state = toSignal(
    this.reload$.pipe(
      switchMap(() =>
        this.service
          .getProducts()
          .pipe(toLoadState(environment.messages.loadProductsError, (m) => this.alerts.error(m))),
      ),
    ),
    { initialValue: { status: 'loading' } as LoadState<Product[]> },
  );

  protected readonly filtered = computed<Product[]>(() => {
    const s = this.state();
    if (s.status !== 'success') return [];
    const t = this.term().trim().toLowerCase();
    return t
      ? s.data.filter(
          (p) => p.title.toLowerCase().includes(t) || p.category.toLowerCase().includes(t),
        )
      : s.data;
  });

  protected reload(): void {
    this.reload$.next();
  }

  protected showDetail(product: Product): void {
    this.alerts.info(product.title, product.description);
  }
}
