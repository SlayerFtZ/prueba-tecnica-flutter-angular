import { Pipe, PipeTransform } from '@angular/core';

@Pipe({ name: 'discountPercent' })
export class DiscountPercentPipe implements PipeTransform {
  transform(total: number, discountedTotal: number): string {
    if (total <= 0) return '0%';
    return `${(((total - discountedTotal) / total) * 100).toFixed(1)}%`;
  }
}
