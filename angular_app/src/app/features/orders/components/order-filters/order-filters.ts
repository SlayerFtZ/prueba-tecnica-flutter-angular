import { ChangeDetectionStrategy, Component } from '@angular/core';
import { outputFromObservable } from '@angular/core/rxjs-interop';
import { FormControl, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { map } from 'rxjs';

export interface OrderFilters {
  minTotal: number | null;
  userId: number | null;
}

@Component({
  selector: 'app-order-filters',
  imports: [ReactiveFormsModule],
  changeDetection: ChangeDetectionStrategy.OnPush,
  styleUrl: './order-filters.css',
  templateUrl: './order-filters.html',
})
export class OrderFiltersComponent {
  protected readonly form = new FormGroup({
    minTotal: new FormControl<number | null>(null),
    userId: new FormControl<number | null>(null),
  });

  readonly filtersChange = outputFromObservable(
    this.form.valueChanges.pipe(map((): OrderFilters => this.form.getRawValue())),
  );

  protected clear(): void {
    this.form.reset();
  }
}
