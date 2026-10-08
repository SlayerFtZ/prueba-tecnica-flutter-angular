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

type SortKey = 'default' | 'price-asc' | 'price-desc' | 'rating' | 'stock';

@Component({
  selector: 'app-products-page',
  imports: [ReactiveFormsModule, ProductCardComponent, LoadingStateComponent, ErrorStateComponent],
  changeDetection: ChangeDetectionStrategy.OnPush,
  templateUrl: './products-page.html',
})
export class ProductsPageComponent {
  private readonly service = inject(ProductsService);
  private readonly alerts = inject(AlertService);
  private readonly reload$ = new BehaviorSubject<void>(undefined);

  protected readonly search = new FormControl('', { nonNullable: true });
  protected readonly category = new FormControl('', { nonNullable: true });
  protected readonly sort = new FormControl<SortKey>('default', { nonNullable: true });
  protected readonly inStock = new FormControl(false, { nonNullable: true });

  private readonly term = toSignal(this.search.valueChanges, { initialValue: '' });
  private readonly categoryValue = toSignal(this.category.valueChanges, { initialValue: '' });
  private readonly sortValue = toSignal(this.sort.valueChanges, {
    initialValue: 'default' as SortKey,
  });
  private readonly inStockValue = toSignal(this.inStock.valueChanges, { initialValue: false });

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

  protected readonly categories = computed<string[]>(() => {
    const s = this.state();
    if (s.status !== 'success') return [];
    return [...new Set(s.data.map((p) => p.category))].sort();
  });

  protected readonly filtered = computed<Product[]>(() => {
    const s = this.state();
    if (s.status !== 'success') return [];

    const t = this.term().trim().toLowerCase();
    const cat = this.categoryValue();
    const onlyStock = this.inStockValue();

    const list = s.data.filter(
      (p) =>
        (!t || p.title.toLowerCase().includes(t) || p.category.toLowerCase().includes(t)) &&
        (!cat || p.category === cat) &&
        (!onlyStock || p.stock > 0),
    );

    switch (this.sortValue()) {
      case 'price-asc':
        return [...list].sort((a, b) => a.price - b.price);
      case 'price-desc':
        return [...list].sort((a, b) => b.price - a.price);
      case 'rating':
        return [...list].sort((a, b) => b.rating - a.rating);
      case 'stock':
        return [...list].sort((a, b) => b.stock - a.stock);
      default:
        return list;
    }
  });

  protected readonly activeCount = computed(
    () =>
      (this.term().trim() ? 1 : 0) +
      (this.categoryValue() ? 1 : 0) +
      (this.inStockValue() ? 1 : 0) +
      (this.sortValue() !== 'default' ? 1 : 0),
  );

  protected reload(): void {
    this.reload$.next();
  }

  protected clear(): void {
    this.search.reset();
    this.category.reset();
    this.sort.reset();
    this.inStock.reset();
  }

  protected showDetail(product: Product): void {
    this.alerts.info(product.title, product.description);
  }
}
