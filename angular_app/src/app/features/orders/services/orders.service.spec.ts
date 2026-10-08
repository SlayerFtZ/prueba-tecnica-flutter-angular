import { TestBed } from '@angular/core/testing';
import { provideHttpClient } from '@angular/common/http';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { OrdersService } from './orders.service';
import { Order, OrdersResponse } from '../models/order.model';

const order = (id: number): Order => ({
  id,
  userId: 1,
  total: 100,
  discountedTotal: 90,
  totalProducts: 1,
  totalQuantity: 2,
  products: [],
});

describe('OrdersService', () => {
  let service: OrdersService;
  let http: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [provideHttpClient(), provideHttpClientTesting()],
    });
    service = TestBed.inject(OrdersService);
    http = TestBed.inject(HttpTestingController);
  });

  afterEach(() => http.verify());

  it('getOrders hace GET y devuelve solo el arreglo carts', () => {
    let result: Order[] | undefined;
    service.getOrders().subscribe((r) => (result = r));

    const req = http.expectOne((r) => r.url.endsWith('/carts'));
    expect(req.request.method).toBe('GET');
    const body: OrdersResponse = { carts: [order(1), order(2)], total: 2, skip: 0, limit: 30 };
    req.flush(body);

    expect(result?.map((o) => o.id)).toEqual([1, 2]);
  });

  it('getOrder pide /carts/:id', () => {
    let result: Order | undefined;
    service.getOrder(5).subscribe((r) => (result = r));

    const req = http.expectOne((r) => r.url.endsWith('/carts/5'));
    req.flush(order(5));

    expect(result?.id).toBe(5);
  });

  it('propaga el error HTTP', () => {
    let status: number | undefined;
    service.getOrder(999).subscribe({ error: (e: { status: number }) => (status = e.status) });

    http.expectOne((r) => r.url.endsWith('/carts/999')).flush('x', { status: 404, statusText: 'Not Found' });

    expect(status).toBe(404);
  });
});
