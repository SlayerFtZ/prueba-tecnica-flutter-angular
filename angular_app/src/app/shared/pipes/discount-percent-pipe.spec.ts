import { DiscountPercentPipe } from './discount-percent-pipe';

describe('DiscountPercentPipe', () => {
  const pipe = new DiscountPercentPipe();

  it('calcula el porcentaje de descuento', () => {
    expect(pipe.transform(200, 150)).toBe('25.0%');
  });

  it('devuelve 0% cuando el total es 0', () => {
    expect(pipe.transform(0, 0)).toBe('0%');
  });
});
