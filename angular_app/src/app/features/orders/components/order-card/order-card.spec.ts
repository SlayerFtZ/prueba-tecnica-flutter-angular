import { ComponentFixture, TestBed } from '@angular/core/testing';
import { OrderCardComponent } from './order-card';
import { Order } from '../../models/order.model';

const order: Order = {
  id: 7,
  userId: 3,
  total: 200,
  discountedTotal: 150,
  totalProducts: 2,
  totalQuantity: 4,
  products: [],
};

describe('OrderCardComponent', () => {
  let fixture: ComponentFixture<OrderCardComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({ imports: [OrderCardComponent] }).compileComponents();
    fixture = TestBed.createComponent(OrderCardComponent);
    fixture.componentRef.setInput('order', order);
    await fixture.whenStable();
  });

  it('muestra los datos del pedido y el descuento', () => {
    const text = (fixture.nativeElement as HTMLElement).textContent ?? '';
    expect(text).toContain('Pedido #7');
    expect(text).toContain('Usuario 3');
    expect(text).toContain('25.0%');
  });

  it('emite viewDetail con el id al pulsar "Ver detalle"', () => {
    const spy = vi.fn();
    fixture.componentInstance.viewDetail.subscribe(spy);

    (fixture.nativeElement as HTMLElement).querySelector('button')?.click();

    expect(spy).toHaveBeenCalledWith(7);
  });
});
