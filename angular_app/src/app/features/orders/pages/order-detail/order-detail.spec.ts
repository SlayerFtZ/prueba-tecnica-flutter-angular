import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter } from '@angular/router';
import { NEVER, of, throwError } from 'rxjs';
import { AlertService } from '@core/services/alert.service';
import { OrderDetailComponent } from './order-detail';
import { OrdersService } from '../../services/orders.service';
import { Order } from '../../models/order.model';

const order: Order = {
  id: 1,
  userId: 9,
  total: 200,
  discountedTotal: 150,
  totalProducts: 1,
  totalQuantity: 2,
  products: [],
};

describe('OrderDetailComponent', () => {
  let fixture: ComponentFixture<OrderDetailComponent>;
  const el = () => fixture.nativeElement as HTMLElement;

  function setup(getOrder: () => unknown) {
    TestBed.configureTestingModule({
      imports: [OrderDetailComponent],
      providers: [
        provideRouter([]),
        { provide: OrdersService, useValue: { getOrder } },
        { provide: AlertService, useValue: { error: vi.fn() } },
      ],
    });
    fixture = TestBed.createComponent(OrderDetailComponent);
    fixture.componentRef.setInput('id', '1');
  }

  it('muestra el estado de carga', async () => {
    setup(() => NEVER);
    await fixture.whenStable();
    expect(el().querySelector('app-loading-state')).not.toBeNull();
  });

  it('muestra el detalle del pedido', async () => {
    setup(() => of(order));
    await fixture.whenStable();
    expect(el().textContent).toContain('Pedido #1');
    expect(el().textContent).toContain('Usuario 9');
  });

  it('muestra el error si falla la petición', async () => {
    setup(() => throwError(() => new Error('fail')));
    await fixture.whenStable();
    expect(el().querySelector('[role="alert"]')).not.toBeNull();
  });
});
