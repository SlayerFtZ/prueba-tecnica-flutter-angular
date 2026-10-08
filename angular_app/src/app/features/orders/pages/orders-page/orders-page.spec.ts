import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter } from '@angular/router';
import { NEVER, of, throwError } from 'rxjs';
import { AlertService } from '@core/services/alert.service';
import { OrdersPageComponent } from './orders-page';
import { OrdersService } from '../../services/orders.service';
import { Order } from '../../models/order.model';

const make = (id: number, userId: number, total: number): Order => ({
  id, userId, total, discountedTotal: total * 0.9, totalProducts: 1, totalQuantity: 1, products: [],
});

describe('OrdersPageComponent', () => {
  let fixture: ComponentFixture<OrdersPageComponent>;
  const el = () => fixture.nativeElement as HTMLElement;

  function setup(getOrders: () => unknown) {
    TestBed.configureTestingModule({
      imports: [OrdersPageComponent],
      providers: [
        provideRouter([]),
        { provide: OrdersService, useValue: { getOrders } },
        { provide: AlertService, useValue: { error: vi.fn() } },
      ],
    });
    fixture = TestBed.createComponent(OrdersPageComponent);
  }

  it('muestra el estado de carga', async () => {
    setup(() => NEVER);
    await fixture.whenStable();
    expect(el().querySelector('app-loading-state')).not.toBeNull();
  });

  it('muestra el estado de error', async () => {
    setup(() => throwError(() => new Error('fail')));
    await fixture.whenStable();
    expect(el().querySelector('app-error-state')).not.toBeNull();
  });

  it('renderiza una tarjeta por pedido y filtra por total mínimo', async () => {
    setup(() => of([make(1, 1, 100), make(2, 2, 500), make(3, 3, 900)]));
    await fixture.whenStable();
    expect(el().querySelectorAll('app-order-card').length).toBe(3);

    const input = el().querySelector<HTMLInputElement>('input[formControlName="minTotal"]')!;
    input.value = '400';
    input.dispatchEvent(new Event('input'));
    await fixture.whenStable();

    expect(el().querySelectorAll('app-order-card').length).toBe(2);
  });
});
