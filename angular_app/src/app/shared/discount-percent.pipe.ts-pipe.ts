import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'discountPercentPipeTs',
})
export class DiscountPercentPipeTsPipe implements PipeTransform {
  transform(value: unknown, ...args: unknown[]): unknown {
    return null;
  }
}
